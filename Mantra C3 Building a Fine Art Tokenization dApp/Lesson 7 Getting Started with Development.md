# Getting Started with Development

Welcome to the exciting phase of our journey where we start building our Fine Art Tokenization dApp! In this lesson, we'll clone our project repository, explore its structure, and begin implementing key functionalities for our smart contract.

## Cloning the Project Repository

Let's begin by cloning the boilerplate repository that contains the basic structure of our project. Open your terminal and run the following command:

```bash
git clone [https://github.com/0xmetaschool/build-fine-art-tokenization-dApp-on-mantra](https://github.com/0xmetaschool/build-fine-art-tokenization-dApp-on-mantra)
cd [build-fine-art-tokenization-dApp-on-mantra](https://github.com/0xmetaschool/build-fine-art-tokenization-dApp-on-mantra)
```

It's important to note that as we're using CW721, we need to implement all the methods defined in the trait as learned in Lesson 5. However, to streamline our learning process and focus on the core functionality of our Fine Art Tokenization dApp dApp, we've taken the following approach:

1. **Pre-implemented Functions**: The boilerplate code already includes implementations for CW721 functions that are standard across NFT contracts but not central to our specific dApp's unique features. This includes functions like `transfer_nft`, `send_nft`, `approve`, `revoke`, etc.
2. **Functions to Implement**: We'll be focusing on implementing and customizing functions that are crucial to our Fine Art Tokenization dApp dApp's specific requirements. These include:
    - Minting functionality with custom limits
    - Queries specific to our NFT details
    - Any additional features unique to our Fine Art Tokenization dApp

This approach allows us to learn by doing, focusing on the most relevant parts of the contract for our specific use case, while ensuring we meet all CW721 standard requirements.

As we progress through the lessons, we'll implement these key functions step by step, building upon the provided boilerplate to create our Fine Art Tokenization dApp.

**Note: Don’t worry if you see errors in the boilerplate, as we keep on adding the code, the errors will be removed.**

## Understanding lib.rs

Let's examine the `lib.rs` file, which serves as the entry point for our Rust library. You can find this file at `/src/lib.rs`. We'll break it down into sections and explain each part.

### Module Declarations

```solidity
mod error;
mod execute;
pub mod helpers;
pub mod msg;
mod query;
pub mod state;
```

This section declares the modules used in our contract. The `mod` keyword is used to declare private modules, while `pub mod` makes the module public, allowing it to be used from outside this crate.

- `error`: Defines custom error types for our contract.
- `execute`: Contains the execution logic for our contract's functions.
- `helpers`: Provides utility functions to interact with the contract.
- `msg`: Defines the message structures for contract interaction.
- `query`: Implements query functions to retrieve contract state.
- `state`: Defines the contract's state and storage.

### Public Exports

```solidity
pub use crate::error::ContractError;
pub use crate::msg::{ExecuteMsg, InstantiateMsg, MintMsg, MinterResponse, QueryMsg};
pub use crate::state::Cw721Contract;
use cosmwasm_std::Empty;
```

These lines make certain types and structures publicly available:

- `pub use crate::error::ContractError`: This allows other parts of our codebase (and potentially external users) to use our custom error type. It's crucial for proper error handling and reporting.
- `pub use crate::msg::{...}`: This exposes the main message types used for contract interaction. `ExecuteMsg` is used for state-changing operations, `InstantiateMsg` for contract initialization, `MintMsg` specifically for minting NFTs, `MinterResponse` for queries about the minter, and `QueryMsg` for read-only operations.
- `pub use crate::state::Cw721Contract`: This makes our main contract struct publicly accessible. It's the core of our NFT implementation, based on the CW721 standard.
- `use cosmwasm_std::Empty`: This imports the `Empty` type from the `cosmwasm_std` crate. It's used in our type alias below.

### Type Alias

```solidity
pub type Extension = Option<Empty>;
```

This line creates a type alias `Extension` as an `Option<Empty>`. In the context of CW721 tokens:

- `Extension` is typically used to add custom data to NFTs beyond the standard fields.
- By setting it to `Option<Empty>`, we're essentially saying our NFTs don't have any additional custom data.
- If we wanted to add custom data later, we could change this to a custom struct instead of `Empty`.

### Entry Points

```solidity
#[cfg(not(feature = "library"))]
pub mod entry {
    // ... (content inside this module)
}
```

This module defines the entry points for our smart contract. The `#[cfg(not(feature = "library"))]` attribute is a conditional compilation flag. It ensures these entry points are only compiled when we're not building as a library. This is useful for testing or if we want to use parts of this contract in another contract without including the entry points.

![Screenshot 2024-09-26 at 4.13.44 PM.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%207%20Getting%20Started%20with%20Development/Screenshot_2024-09-26_at_4.13.44_PM.webp?raw=true)

**Now inside this module add the code which we are going to explain moving ahead.**

Inside this module, add the below lines:

```solidity
use super::*;

use cosmwasm_std::entry_point;
use cosmwasm_std::{Binary, Deps, DepsMut, Env, MessageInfo, Response, StdResult};
```

These lines import necessary items:

- `use super::*;` brings all items from the parent module into scope.
- The rest import specific items from `cosmwasm_std`, which are crucial for writing CosmWasm smart contracts.

### Instantiate Entry Point

Add the below code:

```solidity
#[entry_point]
pub fn instantiate(
    deps: DepsMut,
    env: Env,
    info: MessageInfo,
    msg: InstantiateMsg,
) -> StdResult<Response> {
    let tract = Cw721Contract::<Extension, Empty>::default();
    tract.instantiate(deps, env, info, msg)
}
```

This function is called when the contract is first deployed. Let's break it down:

- `#[entry_point]` is a macro that marks this function as a CosmWasm entry point.
- It takes several parameters:
    - `deps: DepsMut`: Provides mutable access to the contract's dependencies, including storage.
    - `env: Env`: Contains information about the current blockchain environment.
    - `info: MessageInfo`: Provides metadata about the incoming message, like the sender.
    - `msg: InstantiateMsg`: Contains the initialization parameters for our contract.
- Inside the function:
    - We create a new `Cw721Contract` instance.
    - We then call its `instantiate` method, passing along all the parameters we received.
- It returns a `StdResult<Response>`, which will contain the result of the instantiation.

### Execute Entry Point

Add the below code:

```solidity
#[entry_point]
pub fn execute(
    deps: DepsMut,
    env: Env,
    info: MessageInfo,
    msg: ExecuteMsg<Extension>,
) -> Result<Response, ContractError> {
    let tract = Cw721Contract::<Extension, Empty>::default();
    tract.execute(deps, env, info, msg)
}
```

This function handles all execute messages sent to the contract:

- It's similar to `instantiate`, but takes an `ExecuteMsg<Extension>` instead of `InstantiateMsg`.
- The `Extension` type parameter corresponds to our `Extension` type alias defined earlier.
- Inside the function, we again create a `Cw721Contract` instance and delegate to its `execute` method.
- It returns a `Result<Response, ContractError>`, allowing for custom error handling.

### Query Entry Point

```solidity
#[entry_point]
pub fn query(deps: Deps, env: Env, msg: QueryMsg) -> StdResult<Binary> {
    let tract = Cw721Contract::<Extension, Empty>::default();
    tract.query(deps, env, msg)
}
```

This function handles all query messages sent to the contract:

- It takes `Deps` instead of `DepsMut` because queries don't modify state.
- It doesn't need `MessageInfo` because queries don't depend on who's asking.
- The `QueryMsg` parameter specifies what information is being requested.
- Like the other entry points, it creates a `Cw721Contract` instance and delegates to its `query` method.
- It returns a `StdResult<Binary>`, where the `Binary` type represents the encoded response data.

![Screenshot 2024-09-26 at 4.14.33 PM.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%207%20Getting%20Started%20with%20Development/Screenshot_2024-09-26_at_4.14.33_PM.webp?raw=true)

The `lib.rs` file is the backbone of our smart contract. It organizes our code into modules, provides public interfaces for interaction, and defines the critical entry points that the CosmWasm runtime will call.

## Quick Check Point

Update your code to the forked GitHub Repository using the following commands: 

```bash
git add .
git commit -m "updated lib.rs"
git push
```

### Wrap up

So, we have finally started developing our dApp. By leveraging the CW721 implementation (`Cw721Contract`), we ensure our contract adheres to the NFT standard. This allows us to focus on implementing the unique features of our project in the other modules, particularly in `execute.rs` for minting logic and `query.rs` for NFT-specific queries.

In the upcoming lessons, we'll dive deeper into these other modules, implementing our custom functionality while building upon this solid foundation provided by the CW721 standard.