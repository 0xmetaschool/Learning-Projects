# Project Setup and Contract Initialization

Hello folks! Good job in setting up the environment for our coding time. Now in this lesson, we will start working on our lending dApp project finally. Let’s dive right into it~

## Git Checkout

As always we are here for you! So we have set up a boilerplate code for you to run. Run the following commands:

```
gh repo fork https://github.com/0xmetaschool/build-lending-dApp-on-mantra.git --clone
```

You will see a project structure similar to this:

![Frame 3560435.jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%204%20Project%20Setup%20and%20Contract%20Initialization/Frame_3560435.webp?raw=true)

So we talked about how we need USD and TestOM tokens to process with the functionality of the dApp. So first we will explore the `Token` folder to create both of these coins/currencies and then we will proceed to use them in our Lending dApp.

Let’s explore the `Token`~ Run the following commands to get us ready to run our files.

```jsx
cd Token

cargo build --target wasm32-unknown-unknown --release

docker run --rm -v "$(pwd)":/code \
  --mount type=volume,source="$(basename "$(pwd)")_cache",target=/code/target \
  --mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
  cosmwasm/rust-optimizer:0.16.0
  
 source mantrachain-cli.env 
```

## Coding time 👨🏼‍💻

Navigate to the `Token/src/contract.rs`.

### Module Imports and Configuration

```rust
#[cfg(not(feature = "library"))]
use cosmwasm_std::entry_point;
use cosmwasm_std::{
    to_binary, Binary, Deps, DepsMut, Env, MessageInfo, Response, StdResult,
};
use cw20_base::ContractError;
use cw20_base::enumerable::{query_all_allowances, query_all_accounts};
use cw20_base::msg::{QueryMsg,ExecuteMsg};

use crate::msg::MigrateMsg;
use cw2::set_contract_version;
// ... (more imports)

```

- This section imports necessary modules and types from `cosmwasm_std` and `cw20_base`.
- The `#[cfg(not(feature = "library"))]` attribute ensures that the `entry_point` macro is only used when not compiling as a library.
- It imports various functions and types related to CW20 token standard implementation.

### Contract Version Information

```rust
const CONTRACT_NAME: &str = "crates.io:cw20-token";
const CONTRACT_VERSION: &str = env!("CARGO_PKG_VERSION");

```

- Defines constants for the contract name and version.
- `env!("CARGO_PKG_VERSION")` retrieves the version from the package's Cargo.toml file.

### Instantiate Function

```rust
#[cfg_attr(not(feature = "library"), entry_point)]
pub fn instantiate(
    deps: DepsMut,
    env: Env,
    info: MessageInfo,
    msg: cw20_base::msg::InstantiateMsg,
) -> Result<Response, ContractError> {
    set_contract_version(deps.storage, CONTRACT_NAME, CONTRACT_VERSION)?;
    Ok(cw20_base::contract::instantiate(deps, env, info, msg)?)
}

```

- This function is called when the contract is first deployed.
- It sets the contract version in storage.
- It delegates the actual instantiation to the `cw20_base` implementation.

### Execute Function

```rust
#[cfg_attr(not(feature = "library"), entry_point)]
pub fn execute(
    deps: DepsMut,
    env: Env,
    info: MessageInfo,
    msg: ExecuteMsg,
) -> Result<Response, cw20_base::ContractError> {
    match msg {
        ExecuteMsg::Transfer { recipient, amount } => {
            execute_transfer(deps, env, info, recipient, amount)
        }
        ExecuteMsg::Burn { amount } => execute_burn(deps, env, info, amount),
        ExecuteMsg::Send {
            contract,
            amount,
            msg,
        } => execute_send(deps, env, info, contract, amount, msg),
        ExecuteMsg::Mint { recipient, amount } => execute_mint(deps, env, info, recipient, amount),
        ExecuteMsg::IncreaseAllowance {
            spender,
            amount,
            expires,
        } => execute_increase_allowance(deps, env, info, spender, amount, expires),
        ExecuteMsg::DecreaseAllowance {
            spender,
            amount,
            expires,
        } => execute_decrease_allowance(deps, env, info, spender, amount, expires),
        ExecuteMsg::TransferFrom {
            owner,
            recipient,
            amount,
        } => execute_transfer_from(deps, env, info, owner, recipient, amount),
        ExecuteMsg::BurnFrom { owner, amount } => execute_burn_from(deps, env, info, owner, amount),
        ExecuteMsg::SendFrom {
            owner,
            contract,
            amount,
            msg,
        } => execute_send_from(deps, env, info, owner, contract, amount, msg),
        ExecuteMsg::UpdateMarketing {
            project,
            description,
            marketing,
        } => execute_update_marketing(deps, env, info, project, description, marketing),
        ExecuteMsg::UploadLogo(logo) => execute_upload_logo(deps, env, info, logo),
    }
}
```

- This function handles all executable actions on the contract.
- It uses pattern matching to route different message types to their respective handler functions.
- Supported actions include token transfers, burning, minting, allowance management, and marketing info updates.
- All actual implementations are delegated to functions from the `cw20_base` crate.

### Query Function

```rust
#[cfg_attr(not(feature = "library"), entry_point)]
pub fn query(deps: Deps, _env: Env, msg: QueryMsg) -> StdResult<Binary> {
    match msg {
        QueryMsg::Balance { address } => to_binary(&query_balance(deps, address)?),
        QueryMsg::TokenInfo {} => to_binary(&query_token_info(deps)?),
        QueryMsg::Minter {} => to_binary(&query_minter(deps)?),
        QueryMsg::Allowance { owner, spender } => {
            to_binary(&query_allowance(deps, owner, spender)?)
        }
        QueryMsg::AllAllowances {
            owner,
            start_after,
            limit,
        } => to_binary(&query_all_allowances(deps, owner, start_after, limit)?),
        QueryMsg::AllAccounts { start_after, limit } => {
            to_binary(&query_all_accounts(deps, start_after, limit)?)
        }
        QueryMsg::MarketingInfo {} => to_binary(&query_marketing_info(deps)?),
        QueryMsg::DownloadLogo {} => to_binary(&query_download_logo(deps)?),
    }
}
```

- This function handles all read-only queries to the contract.
- It uses pattern matching to route different query types to their respective handler functions.
- Supported queries include balance checks, token info, minter info, allowances, and marketing info.
- All actual implementations are delegated to functions from the `cw20_base` crate.
- The results are serialized to binary format using `to_binary`.

### Migrate Function

```rust
#[cfg_attr(not(feature = "library"), entry_point)]
pub fn migrate(_deps: DepsMut, _env: Env, _msg: MigrateMsg) -> StdResult<Response> {
    Ok(Response::default())
}
```

- This function is called when upgrading the contract.
- In this implementation, it does nothing and returns a default response.
- It's a placeholder for future upgrade logic if needed.

## That’s a Wrap

In summary, our contract implements the CW20 token standard for the Mantra blockchain. It heavily relies on the `cw20_base` crate for most of its functionality, essentially acting as a wrapper around the standard implementation. The contract provides functions for token operations (transfer, burn, mint), allowance management, and querying various token-related information.

Now it’s time to execute it, stay tuned~