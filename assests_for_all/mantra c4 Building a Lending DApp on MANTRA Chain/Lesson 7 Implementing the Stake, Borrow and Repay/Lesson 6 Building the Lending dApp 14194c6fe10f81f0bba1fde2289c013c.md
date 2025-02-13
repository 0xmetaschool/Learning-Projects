# Lesson 6: Building the Lending dApp

Welcome back, folks! So now you have set up both required tokens, it’s time to build the functionality of the lending dApp. Well, let’s not waste a second and dive deep right into it~

![mantra-c4.gif](Lesson%206%20Building%20the%20Lending%20dApp%2014194c6fe10f81f0bba1fde2289c013c/mantra-c4.gif)

## Lending dApp: Time to code! 👨🏼‍💻

Open the terminal and run the following commands:

```bash
cd ../
cd Lending
```

Navigate to the `Lending/src/lib.rs`.

### 1. **Imports**

```rust
use cosmwasm_std::{
    entry_point, to_json_binary, Binary, Deps, DepsMut, Env, MessageInfo, Response, StdResult,
    Uint128, WasmMsg, Addr, from_json, StdError, to_binary,
};
use cw20::{Cw20ExecuteMsg, Cw20ReceiveMsg};

mod error;
mod msg;
mod state;

use crate::error::ContractError;
use crate::msg::{ExecuteMsg, InstantiateMsg, QueryMsg};
use crate::state::{Config, UserInfo, PoolInfo, CONFIG, USERS, POOL};
```

- **cosmwasm_std**: Core utilities from CosmWasm, including types for handling dependencies (`Deps`, `DepsMut`), blockchain state (`Env`, `MessageInfo`), and handling messages (e.g., `WasmMsg`, `StdResult`).
- **cw20**: Imports related to the CW20 token standard, specifically execution and receiving messages.
- **error, msg, state modules**: These are custom modules for handling errors, messages (input/output for the contract), and contract state (configurations and user information).

### 2. **Instantiate Function**

```rust
#[entry_point]
pub fn instantiate(
    deps: DepsMut,
    _env: Env,
    info: MessageInfo,
    msg: InstantiateMsg,
) -> Result<Response, ContractError> {
    let config = Config {
        owner: info.sender.clone(),
        usd_token: deps.api.addr_validate(&msg.usd_token)?,
        om_token: deps.api.addr_validate(&msg.om_token)?,
        collateral_ratio: msg.collateral_ratio,
        interest_rate: msg.interest_rate,
    };
    CONFIG.save(deps.storage, &config)?;

    let pool = PoolInfo {
        total_staked: Uint128::zero(),
        total_borrowed: Uint128::zero(),
    };
    POOL.save(deps.storage, &pool)?;

    Ok(Response::new().add_attribute("method", "instantiate"))
}
```

- **instantiate**: This function initializes the contract with the given configuration.
    - **Config**: Stores contract-level settings, such as:
        - `owner`: The address of the contract creator.
        - `usd_token` and `om_token`: Validates and stores the USD and OM token contract addresses.
        - `collateral_ratio` and `interest_rate`: Custom values related to the pool's lending/borrowing system.
    - **PoolInfo**: Initializes the pool with zero staked and borrowed values.
    - **Response**: Returns a success message with the attribute `instantiate`.

### 3. **Execute Function**

```rust
#[entry_point]
pub fn execute(
    deps: DepsMut,
    env: Env,
    info: MessageInfo,
    msg: ExecuteMsg,
) -> Result<Response, ContractError> {
    match msg {
        ExecuteMsg::Stake {} => execute::stake(deps, env, info),
        ExecuteMsg::Unstake { amount } => execute::unstake(deps, env, info, amount),
        ExecuteMsg::Borrow { amount } => execute::borrow(deps, env, info, amount),
        ExecuteMsg::Repay {} => execute::repay(deps, env, info),
        ExecuteMsg::Receive(msg) => receive_cw20(deps, env, info, msg),
    }
}
```

- **execute**: Handles various commands (defined in `ExecuteMsg`) to modify the contract's state.
    - **Stake**: Calls the `stake` function when a user stakes tokens.
    - **Unstake**: Calls the `unstake` function, allowing users to withdraw a specific amount.
    - **Borrow**: Handles borrowing tokens from the pool.
    - **Repay**: Allows users to repay borrowed tokens.
    - **Receive**: Used when receiving CW20 tokens, which triggers the `receive_cw20` function.

### 4. **receive_cw20 Function**

```rust
pub fn receive_cw20(
    deps: DepsMut,
    env: Env,
    info: MessageInfo,
    cw20_msg: Cw20ReceiveMsg,
) -> Result<Response, ContractError> {
    match from_json(&cw20_msg.msg) {
        Ok(ExecuteMsg::Stake {}) => execute::stake(deps, env, info),
        Ok(ExecuteMsg::Repay {}) => execute::repay(deps, env, info),
        _ => Err(ContractError::InvalidCw20Hook {}),
    }
}
```

- **receive_cw20**: Handles CW20 token transfers to the contract and calls appropriate actions based on the message.
    - **cw20_msg**: The CW20 message sent with the token transfer, which is decoded using `from_json`.
    - **Stake and Repay**: If the message matches these actions, the respective function is called.
    - **InvalidCw20Hook**: Returns an error if the CW20 message is not recognized.

### **5. Query Function**

```
#[entry_point]
pub fn query(deps: Deps, _env: Env, msg: QueryMsg) -> StdResult<Binary> {
    match msg {
        QueryMsg::GetConfig {} => to_json_binary(&query::config(deps)?),
        QueryMsg::GetUserInfo { address } => to_json_binary(&query::user_info(deps, address)?),
        QueryMsg::GetPoolInfo {} => to_json_binary(&query::pool_info(deps)?),
    }
}
```

- **Entry Point:** The `query` function is marked as an entry point using the `#[entry_point]` attribute, making it accessible from external sources.
- **Query Message Handling:** The function takes a `QueryMsg` as input and uses a `match` expression to determine the appropriate action based on the query type.
- **Configuration Query:** If the query is for the contract's configuration, the `query::config` function is called and the result is serialized to a `Binary` object using `to_json_binary`.
- **User Information Query:** If the query is for a user's information, the `query::user_info` function is called with the user's address as an argument, and the result is serialized to a `Binary` object.
- **Pool Information Query:** If the query is for information about a pool, the `query::pool_info` function is called and the result is serialized to a `Binary` object.

### 6. **`stake` Function**

```rust
pub fn stake(deps: DepsMut, env: Env, info: MessageInfo) -> Result<Response, ContractError> {
    let config = CONFIG.load(deps.storage)?;
    let mut pool = POOL.load(deps.storage)?;
    let amount = info.funds.iter().find(|c| c.denom == config.usd_token.to_string())
        .map(|c| c.amount)
        .ok_or(ContractError::NoFunds {})?;

    let mut user = USERS.may_load(deps.storage, &info.sender)?.unwrap_or_default();
    user.staked_amount += amount;
    USERS.save(deps.storage, &info.sender, &user)?;

    pool.total_staked += amount;
    POOL.save(deps.storage, &pool)?;

    Ok(Response::new().add_attribute("action", "stake"))
}
```

This function handles the staking action, where users send tokens to stake, and the contract records the amount staked.

- **Load Configuration**: Fetches the contract's configuration using `CONFIG.load()`.
- **Load Pool Data**: Fetches the pool data (e.g., total staked tokens) using `POOL.load()`.
- **Find Stake Amount**: Looks for the funds the user has sent, specifically in the denomination of the token specified in `config.usd_token`. If no valid funds are found, it throws a `ContractError::NoFunds` error.
- **Update User**: Loads the user's staking info and increases their `staked_amount` by the received amount. If the user does not exist, it initializes them with default values.
- **Update Pool**: Increments the total staked amount in the pool with the new stake.
- **Save Changes**: Saves the updated user and pool data to storage.
- **Return Response**: Returns a `Response` that includes the action attribute ("stake").

### 7. **`unstake` Function**

```rust
pub fn unstake(deps: DepsMut, _env: Env, info: MessageInfo, amount: Uint128) -> Result<Response, ContractError> {
    let config = CONFIG.load(deps.storage)?;
    let mut pool = POOL.load(deps.storage)?;
    let mut user = USERS.load(deps.storage, &info.sender)?;

    if user.staked_amount < amount {
        return Err(ContractError::InsufficientFunds {});
    }

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
        .add_attribute("amount", amount.to_string()))
}
```

This function handles unstaking, where users withdraw staked tokens, and the contract transfers the tokens back to the user.

- **Load Configuration**: Retrieves contract configuration data.
- **Load Pool Data**: Fetches the current pool information.
- **Load User Data**: Fetches the user’s staking data.
- **Check Balance**: Verifies if the user has enough staked tokens. If the requested `amount` is larger than their current `staked_amount`, the function returns a `ContractError::InsufficientFunds`.
- **Update User**: Reduces the user’s staked amount by the specified `amount`.
- **Update Pool**: Decreases the total staked amount in the pool.
- **Transfer Tokens**: Creates a message (`WasmMsg::Execute`) to transfer the unstaked amount back to the user using the token contract.
- **Return Response**: Returns a response that includes the action ("unstake") and the unstaked amount.

## That’s a wrap

We have instantiated and implemented the stake and unstake functionality, Time to borrow and repay functions in the next lesson.