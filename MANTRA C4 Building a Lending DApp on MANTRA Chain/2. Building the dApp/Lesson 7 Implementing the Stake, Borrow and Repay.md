# Implementing the Stake, Borrow and Repay Functionality

Bestiesss, you have done great so far. Just hang on for a while and we will be soon done implementing the complete functionality of our Lending dApp. Let’s dive right away~

![Frame 3560439.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%207%20Implementing%20the%20Stake%2C%20Borrow%20and%20Repay/Frame_3560439.webp?raw=true)

## Time to code 👨🏼‍💻

We're working in the `Lending/src/lib.rs` file. Let's break down each function and understand what they do!

## Core Functions

### `stake` Function

This function allows users to stake their USD tokens as collateral:

```rust
pub fn stake(deps: DepsMut, _env: Env, sender: String, amount: Uint128) -> Result<Response, ContractError> {
    let sender_addr = deps.api.addr_validate(&sender)?;
    let mut pool = POOL.load(deps.storage)?;

    let mut user = USERS
        .may_load(deps.storage, &sender_addr)?
        .unwrap_or_default();
    user.staked_amount += amount;
    USERS.save(deps.storage, &sender_addr, &user)?;

    pool.total_staked += amount;
    POOL.save(deps.storage, &pool)?;

    Ok(Response::new()
        .add_attribute("action", "stake")
        .add_attribute("amount", amount)
        .add_attribute("sender", sender))
}

```

- Validates the sender's address
- Creates or updates user's staking record
- Updates the pool's total staked amount
- Returns success response with relevant attributes

### `borrow` Function

Allows users to borrow OM tokens against their staked collateral:

```rust
pub fn borrow(deps: DepsMut, env: Env, info: MessageInfo, amount: Uint128) -> Result<Response, ContractError> {
    let config = CONFIG.load(deps.storage)?;
    let mut pool = POOL.load(deps.storage)?;
    let mut user = USERS.load(deps.storage, &info.sender)?;

    update_user_interest(deps.storage, &env, &config, &info.sender, &mut user)?;

    let total_owed = user.borrowed_amount + user.interest_amount;
    let max_borrow = user
        .staked_amount
        .checked_mul(config.collateral_ratio)?
        .checked_div(Uint128::from(100u128))?
        .checked_sub(total_owed)?;

    if amount > max_borrow {
        return Err(ContractError::ExceedsCollateralRatio {});
    }

    user.borrowed_amount += amount;
    user.last_interest_update = env.block.time.seconds();
    USERS.save(deps.storage, &info.sender, &user)?;

    pool.total_borrowed += amount;
    POOL.save(deps.storage, &pool)?;

    let msg = WasmMsg::Execute {
        contract_addr: config.om_token.to_string(),
        msg: to_binary(&Cw20ExecuteMsg::Transfer {
            recipient: info.sender.to_string(),
            amount,
        })?,
        funds: vec![],
    };

    Ok(Response::new()
        .add_message(msg)
        .add_attribute("action", "borrow")
        .add_attribute("amount", amount))
}

```

- Updates user's interest before processing the borrow
- Calculates maximum borrowable amount based on collateral ratio
- Checks if borrow amount is within limits
- Updates user's borrowed amount and pool stats
- Transfers OM tokens to the borrower

### `repay` Function

Handles repayment of borrowed tokens with interest:

```rust
pub fn repay(deps: DepsMut, env: Env, sender: String, amount: Uint128) -> Result<Response, ContractError> {
    let sender_addr = deps.api.addr_validate(&sender)?;
    let config = CONFIG.load(deps.storage)?;
    let mut pool = POOL.load(deps.storage)?;
    let mut user = USERS.load(deps.storage, &sender_addr)?;

// Handle zero interest case
    if user.interest_amount.is_zero() {
        if amount > user.borrowed_amount {
            return Err(ContractError::ExcessRepayment {});
        }
// ... zero interest handling
    }

// Normal repayment flow with interest
    let total_owed = user.borrowed_amount + user.interest_amount;
    if amount > total_owed {
        return Err(ContractError::ExcessRepayment {});
    }

    let (interest_portion, principal_portion) = user.calculate_interest_portion(amount)?;

// Update user and pool stats
    user.interest_amount = user.interest_amount.checked_sub(interest_portion)?;
    user.borrowed_amount = user.borrowed_amount.checked_sub(principal_portion)?;
    user.last_interest_update = env.block.time.seconds();

    pool.total_borrowed = pool.total_borrowed.checked_sub(principal_portion)?;
    pool.total_interest = pool.total_interest.checked_sub(interest_portion)?;

    USERS.save(deps.storage, &sender_addr, &user)?;
    POOL.save(deps.storage, &pool)?;

    Ok(Response::new()
        .add_attribute("action", "repay")
        .add_attribute("total_amount", amount)
        .add_attribute("interest_paid", interest_portion)
        .add_attribute("principal_paid", principal_portion)
        .add_attribute("remaining_borrowed", user.borrowed_amount)
        .add_attribute("remaining_interest", user.interest_amount)
        .add_attribute("sender", sender))
}

```

- Handles both zero-interest and normal repayment scenarios
- Calculates interest and principal portions of repayment
- Updates user's borrowed amount and interest
- Updates pool statistics
- Returns detailed repayment information

### `unstake` Function

Allows users to withdraw their staked collateral:

```rust
rust
Copy
pub fn unstake(deps: DepsMut, env: Env, info: MessageInfo, amount: Uint128) -> Result<Response, ContractError> {
    let config = CONFIG.load(deps.storage)?;
    let mut pool = POOL.load(deps.storage)?;
    let mut user = USERS.load(deps.storage, &info.sender)?;

    update_user_interest(deps.storage, &env, &config, &info.sender, &mut user)?;

    if user.staked_amount < amount {
        return Err(ContractError::InsufficientFunds {});
    }

    if user.borrowed_amount > Uint128::zero() {
        let remaining_stake = user.staked_amount.checked_sub(amount)?;
        let total_owed = user.borrowed_amount + user.interest_amount;
        let min_required_stake = total_owed
            .checked_mul(Uint128::from(100u128))?
            .checked_div(config.collateral_ratio)?;

        if remaining_stake < min_required_stake {
            return Err(ContractError::ExceedsCollateralRatio {});
        }
    }

// Update state and transfer tokens
    user.staked_amount -= amount;
    USERS.save(deps.storage, &info.sender, &user)?;

    pool.total_staked -= amount;
    POOL.save(deps.storage, &pool)?;

    let msg = WasmMsg::Execute {
        contract_addr: config.usd_token.to_string(),
        msg: to_binary(&Cw20ExecuteMsg::Transfer {
            recipient: info.sender.to_string(),
            amount,
        })?,
        funds: vec![],
    };

    Ok(Response::new()
        .add_message(msg)
        .add_attribute("action", "unstake")
        .add_attribute("amount", amount))
}

```

- Updates interest before processing unstake
- Checks if user has sufficient staked amount
- Ensures remaining collateral maintains required ratio if there are outstanding loans
- Transfers USD tokens back to user

## 2. Query Functions

### `config` Function

```rust
pub fn config(deps: Deps) -> StdResult<Config> {
    CONFIG.load(deps.storage)
}

```

- Retrieves contract configuration

### `user_info` Function

```rust
pub fn user_info(deps: Deps, address: Addr) -> StdResult<UserInfo> {
    USERS.may_load(deps.storage, &address)?.ok_or_else(|| StdError::not_found("UserInfo"))
}

```

- Fetches user's lending information

### `pool_info` Function

```rust
pub fn pool_info(deps: Deps) -> StdResult<PoolInfo> {
    POOL.load(deps.storage)
}

```

- Retrieves pool statistics

### `total_owed` Function

```rust
pub fn total_owed(deps: Deps, env: Env, address: Addr) -> StdResult<TotalOwedResponse> {
    let config = CONFIG.load(deps.storage)?;
    let user = USERS.load(deps.storage, &address)?;

    let time_elapsed = env.block.time.seconds() - user.last_interest_update;
    let current_interest = if time_elapsed > 0 && !user.borrowed_amount.is_zero() {
        let interest_rate = Decimal::from_ratio(config.interest_rate, Uint128::new(100));
        let annual_seconds = 31_536_000u64;
        let interest_multiplier = Decimal::from_ratio(time_elapsed, annual_seconds);
        user.interest_amount + (user.borrowed_amount * interest_rate * interest_multiplier)
    } else {
        user.interest_amount
    };

    Ok(TotalOwedResponse {
        borrowed_amount: user.borrowed_amount,
        interest_amount: current_interest,
        total_owed: user.borrowed_amount + current_interest,
    })
}

```

- Calculates total amount owed including current interest
- Returns borrowed amount, interest amount, and total owed

# Time to deploy

⚠️ Note : Please use the same terminal throughout the end of this lesson. 

## Step 1: Environment Setup

Just like our previous deployments, we'll start by setting up our environment and ensuring our wallet is ready to deploy on the Dukong testnet.

```bash
# Source environment variables
source mantrachain-cli.env

# Verify wallet
WALLET_ADDR=$(mantrachaind keys show wallet2 -a)
echo "Deployer wallet address: $WALLET_ADDR"

# build
cargo build --target wasm32-unknown-unknown --release
```

## Step 2: Contract Optimization

As always, we need to optimize our contract for deployment. This reduces gas costs and ensures efficient execution.

```bash
# Optimize the contract using CosmWasm optimizer
docker run --rm -v "$(pwd)":/code \
  --mount type=volume,source="$(basename "$(pwd)")_cache",target=/target \
  --mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
  cosmwasm/optimizer:0.16.0

```

## Step 3: Store Contract

Time to upload our optimized lending contract to the chain. This will give us a CODE_ID that we'll use for instantiation.

```bash
# Upload the optimized contract
RES=$(mantrachaind tx wasm store artifacts/lending_dapp.wasm --from wallet2 $TXFLAG -y --output json)
# Wait for transaction to be processed
sleep 10

# Get the code ID
TX_HASH=$(echo $RES | jq -r .txhash)
CODE_ID=$(mantrachaind query tx $TX_HASH $NODE -o json | jq -r '.events[] | select(.type == "store_code") | .attributes[] | select(.key == "code_id") | .value')
echo "Code ID: $CODE_ID"

```

## Step 4: Verify Contract Upload

Quick verification step to ensure our contract code was stored properly on chain.

```bash
# Verify the code was stored properly
mantrachaind query wasm code $CODE_ID $NODE --output json

# List contracts for the code ID
mantrachaind query wasm list-contract-by-code $CODE_ID $NODE --output json

```

## Step 5: Instantiate Contract

Now we'll create an instance of our lending contract, setting our token addresses and lending parameters. First, Replace the `your_usd_token_address` and `your_om_token_address` with the deployed contract addresses. 

```bash
# Set token addresses (replace with actual addresses)
USD_TOKEN="your_usd_token_address"
OM_TOKEN="your_om_token_address"
```

Now we can move onto instantiating this contract. 

```bash
# Instantiate the contract
INIT_TX=$(mantrachaind tx wasm instantiate $CODE_ID '{"usd_token":"'$USD_TOKEN'", "om_token":"'$OM_TOKEN'", "interest_rate":"1000", "collateral_ratio":"8000"}' --from wallet2 --label "lending_dapp" $TXFLAG --no-admin --output json -y)
echo "Instantiate response: $INIT_TX"

# Wait for transaction to be processed
sleep 10

# Get the contract address
CONTRACT=$(mantrachaind query wasm list-contract-by-code $CODE_ID $NODE --output json | jq -r '.contracts[-1]')
echo "Contract address: $CONTRACT"
```

## Step 6: Verify Contract State

Standard post-deployment verification to ensure everything is properly initialized.

```bash
# Query contract configuration
mantrachaind query wasm contract-state smart $CONTRACT '{"get_config":{}}' $NODE --output json

# Query pool information
mantrachaind query wasm contract-state smart $CONTRACT '{"get_pool_info":{}}' $NODE --output json

```

## Step 7: Save Deployment Information

Last step - let's save all our deployment information for future reference and frontend integration.

```bash
# Save contract information to a file
cat << EOF > deployment_info.txt
Deployment Information
=====================
Chain ID: $CHAIN_ID
Code ID: $CODE_ID
Contract Address: $CONTRACT
USD Token: $USD_TOKEN
OM Token: $OM_TOKEN
Deployment Time: $(date -u)
EOF

echo "Deployment information saved to deployment_info.txt"
```

You can find the contracts information in the `deployment_info.txt` file created in the Lending Folder.

![Screenshot 2024-11-18 181849.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%207%20Implementing%20the%20Stake%2C%20Borrow%20and%20Repay/Screenshot_2024-11-18_181849.webp?raw=true)

## One last task before we bid adieu

Right now both the USD and OM tokens we had minted earlier is present in our wallet , we will now go in and transfer all the OM tokens to our deployed Lending contract.

Here's the command to transfer all of the OM tokens from your wallet to the lending contract:

```bash
$BINARY tx wasm execute $OM_TOKEN \
'{"transfer": {"recipient": "'$CONTRACT'", "amount": "5000000000"}}' \
--from $WALLET_ADDR \
$TXFLAG
```

Then to verify the transfer:

```bash
$BINARY query wasm contract-state smart $OM_TOKEN \
'{"balance": {"address": "'$CONTRACT'"}}' \
$NODE
```

This will:

1. Transfer the full 5000000000 OM tokens
2. From your wallet ($WALLET_ADDR)
3. To the lending contract ($CONTRACT)

## That’s a Wrap

Yayyyy, we are done. In the next lesson, we will add the frontend to check whether our code works. Stay tuned~