# Defining Messages and State - The Blueprint of Our NFT Contract

Welcome back, devs! In our journey so far, we've explored the concept of tokenizing fine art, set up our development environment, and started building the foundation of our smart contract. Now, it's time to dive deeper into the heart of our NFT contract by defining its messages and state.

In this lesson, we'll focus on two crucial files: `msg.rs` and `state.rs`. These files act as the blueprint for our contract, defining how it can be interacted with and what data it stores. We'll distinguish between standard CW721 implementations and our custom logic for the Fine Art Tokenization dApp.

So lets get started and happy coding!!!

## Messages (msg.rs)

The `msg.rs` file defines the messages that our contract can handle. These messages determine how users and other contracts can interact with our NFT contract.

### Standard CW721 Messages

The standard CW721 messages are already implemented in the boilerplate. Let's review them to understand what functionality is already available:

```solidity
// This code is already in the boilerplate, no need to add it
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use cosmwasm_std::Coin;
use cosmwasm_std::Binary;
use cw721::Expiration;

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, JsonSchema)]
pub struct InstantiateMsg {
    pub name: String,
    pub symbol: String,
    pub minter: String,
}

#[derive(Serialize, Deserialize, Clone, PartialEq, JsonSchema, Debug)]
#[serde(rename_all = "snake_case")]
pub enum ExecuteMsg<T> {
    TransferNft { recipient: String, token_id: String },
    SendNft {
        contract: String,
        token_id: String,
        msg: Binary,
    },
    Approve {
        spender: String,
        token_id: String,
        expires: Option<Expiration>,
    },
    Revoke { spender: String, token_id: String },
    ApproveAll {
        operator: String,
        expires: Option<Expiration>,
    },
    RevokeAll { operator: String },
}

#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, JsonSchema)]
#[serde(rename_all = "snake_case")]
pub enum QueryMsg {
    OwnerOf {
        token_id: String,
        include_expired: Option<bool>,
    },
    Approval {
        token_id: String,
        spender: String,
        include_expired: Option<bool>,
    },
    Approvals {
        token_id: String,
        include_expired: Option<bool>,
    },
    AllOperators {
        owner: String,
        include_expired: Option<bool>,
        start_after: Option<String>,
        limit: Option<u32>,
    },
    NumTokens {},
    ContractInfo {},
    NftInfo {
        token_id: String,
    },
    AllNftInfo {
        token_id: String,
        include_expired: Option<bool>,
    },
    Tokens {
        owner: String,
        start_after: Option<String>,
        limit: Option<u32>,
    },
    AllTokens {
        start_after: Option<String>,
        limit: Option<u32>,
    },
}
```

Let's break down these standard messages:

1. `InstantiateMsg`:
    - This struct is used when deploying the contract.
    - `name`: Sets the name of the NFT collection (e.g., "Art NFT").
    - `symbol`: Defines a short symbol for the collection (e.g., "MonaLisa").
    - `minter`: Specifies the address that has permission to mint new NFTs.
2. `ExecuteMsg`:
    - This enum defines the state-changing operations for the NFT contract.
    - `TransferNft`: Moves an NFT from one owner to another.
    - `SendNft`: Sends an NFT to another contract, allowing for cross-contract calls.
    - `Approve`: Grants permission to a specific address to transfer a particular NFT.
    - `Revoke`: Removes transfer permission for a specific NFT.
    - `ApproveAll`: Grants permission to an operator to manage all of the owner's NFTs.
    - `RevokeAll`: Removes all permissions for a given operator.
3. `QueryMsg`:
    - This enum defines read-only operations to retrieve information from the contract.
    - `OwnerOf`: Gets the owner of a specific NFT.
    - `Approval`: Checks if a specific address is approved to transfer an NFT.
    - `Approvals`: Lists all approvals for a specific NFT.
    - `AllOperators`: Lists all operators for a given owner.
    - `NumTokens`: Returns the total number of NFTs in the contract.
    - `ContractInfo`: Retrieves general information about the contract.
    - `NftInfo`: Gets the metadata for a specific NFT.
    - `AllNftInfo`: Combines `OwnerOf` and `NftInfo` into a single query.
    - `Tokens`: Lists all tokens owned by a given address.
    - `AllTokens`: Lists all tokens in the contract.

These standard messages provide a solid foundation for basic NFT functionality, including transfers, approvals, and querying token information.

### Custom Messages for Fine Art Tokenization

Now, let's add our custom messages for the Fine Art Tokenization dApp. These will extend the existing `ExecuteMsg` enum and add new structs/enums.

Add the following code to the `src/msg.rs` file, be careful as you do not have to override the already given code but add more lines in the existing code:

```rust
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, JsonSchema)]
pub struct InstantiateMsg {
		// existing code
		// add below code in your ide
    pub max_mints: u64,
    pub mint_price: Coin,
    pub token_uri: Option<String>,
}
```

Updated `InstantiateMsg`:

- `max_mints`: The maximum number of NFTs that can be minted in this collection.
- `mint_price`: The price to mint a new NFT, specified as a `Coin` struct.
- `token_uri`: An optional URI for the token metadata, which could be the same for all NFTs in the collection.

![Screenshot 2024-09-26 at 4.19.26 PM.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%208%20Defining%20Messages%20and%20State%20-%20The%20Blueprint/Screenshot_2024-09-26_at_4.19.26_PM.webp?raw=true)

Add the new lines in `ExecuteMsg` function:

```solidity
#[derive(Serialize, Deserialize, Clone, PartialEq, JsonSchema, Debug)]
#[serde(rename_all = "snake_case")]
pub enum ExecuteMsg<T> {
    // ... (existing variants)

		// New code to add
    Mint(MintMsg<T>),
    SetMintConfig { price: Coin, max_mints: u64 },
    ToggleMinting {},
}
```

New `ExecuteMsg` variants:

- `Mint`: Allows minting of new NFTs. It takes a `MintMsg<T>` as an argument, which specifies the owner and any additional data (extension) for the new NFT.
- `SetMintConfig`: Allows the contract owner to set the minting price and maximum number of mints. This is crucial for controlling the economics and rarity of our fine art NFTs.
- `ToggleMinting`: Enables or disables minting. This gives us control over when new NFTs can be created, which could be useful for timed releases or pausing minting if issues arise.

![Screenshot 2024-09-26 at 4.41.35 PM.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%208%20Defining%20Messages%20and%20State%20-%20The%20Blueprint/Screenshot_2024-09-26_at_4.41.35_PM.webp?raw=true)

Add this new struct `MintMsg`:

```solidity
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, JsonSchema)]
pub struct MintMsg<T> {
    pub owner: String,
    pub extension: T,
}
```

`MintMsg<T>`:

- This struct defines the information needed to mint a new NFT.
- `owner`: The address that will own the newly minted NFT.
- `extension`: Any additional custom data for the NFT. This could include details specific to the fine art piece.
    
    ![Screenshot 2024-09-26 at 4.45.12 PM.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%208%20Defining%20Messages%20and%20State%20-%20The%20Blueprint/Screenshot_2024-09-26_at_4.45.12_PM.webp?raw=true)
    

```solidity
// Add this new variant to the existing QueryMsg enum
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, JsonSchema)]
#[serde(rename_all = "snake_case")]
pub enum QueryMsg {
    // ... (existing variants)
    
    // New code to add
    NftDetails {},
}

// Add this new struct
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, JsonSchema)]
pub struct NftDetailsResponse {
    pub token_uri: Option<String>,
    pub mint_price: Coin,
    pub max_mints: u64,
}

// Add this new struct
#[derive(Serialize, Deserialize, Clone, PartialEq, JsonSchema, Debug)]
pub struct MinterResponse {
    pub minter: String,
}

```

1. New `QueryMsg` variant:
    - `NftDetails`: A custom query to get details about our NFT collection. This is important for potential buyers to understand the characteristics of the collection.
2. `NftDetailsResponse`:
    - This struct defines the response format for the `NftDetails` query.
    - `token_uri`: The URI where the NFT metadata is stored. This could point to a detailed description or image of the fine art piece.
    - `mint_price`: The current price to mint an NFT. This allows users to see the current cost of minting.
    - `max_mints`: The maximum number of NFTs that can be minted. This helps establish the rarity of the collection.
- `MinterResponse`:
    - This struct defines the response format for a query about the minter of the NFT collection.
    - `minter`: A string representing the address of the account authorized to mint new NFTs.
    - This information is crucial for verifying the authenticity of the NFTs and for administrative purposes.

![Screenshot 2024-09-26 at 4.45.55 PM.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%208%20Defining%20Messages%20and%20State%20-%20The%20Blueprint/Screenshot_2024-09-26_at_4.45.55_PM.webp?raw=true)

These custom messages and queries allow our contract to handle fine art-specific operations like controlled minting and retrieving collection details, which are crucial for a tokenized fine art platform.

## State (state.rs)

The `state.rs` file defines the data that our contract stores and manages. It represents the current state of our NFT collection.

### Standard CW721 State

The standard CW721 state is already implemented in the boilerplate. Let's review it with detailed explanations:

```rust
use schemars::JsonSchema;
use serde::{Deserialize, Serialize};
use cosmwasm_std::{Addr, BlockInfo, StdResult, Storage, Coin};
use cw721::{ContractInfoResponse, CustomMsg, Cw721, Expiration};
use cw_storage_plus::{Index, IndexList, IndexedMap, Item, Map, MultiIndex};

pub struct Cw721Contract<'a, T, C>
where
    T: Serialize + DeserializeOwned + Clone,
    C: CustomMsg,
{
    pub contract_info: Item<'a, ContractInfoResponse>,
    pub minter: Item<'a, Addr>,
    pub token_count: Item<'a, u64>,
    pub tokens: IndexedMap<'a, &'a str, TokenInfo<T>, TokenIndexes<'a,T>>,
    pub operators: Map<'a, (&'a Addr, &'a Addr), Expiration>,
}

```

Let's break this down line by line:

1. The `use` statements import necessary types and traits.
2. `pub struct Cw721Contract<'a, T, C>` defines the main contract structure:
    - `'a` is a lifetime parameter.
    - `T` is a generic type for token extensions.
    - `C` is a generic type for custom messages.
3. `where T: Serialize + DeserializeOwned + Clone, C: CustomMsg` sets constraints on the generic types.
4. `pub contract_info: Item<'a, ContractInfoResponse>` stores general contract information.
5. `pub minter: Item<'a, Addr>` stores the address allowed to mint new tokens.
6. `pub token_count: Item<'a, u64>` keeps track of the total number of tokens.
7. `pub tokens: IndexedMap<'a, &'a str, TokenInfo<T>, TokenIndexes<'a,T>>` stores token information with indexing.
8. `pub operators: Map<'a, (&'a Addr, &'a Addr), Expiration>` stores operator approvals.

```rust
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq, JsonSchema)]
pub struct TokenInfo<T> {
    pub owner: Addr,
    pub approvals: Vec<Approval>,
    pub token_uri: Option<String>,
    pub extension: T,
}

```

This defines the `TokenInfo` struct:

1. `pub owner: Addr` stores the token owner's address.
2. `pub approvals: Vec<Approval>` stores a list of approval information.
3. `pub token_uri: Option<String>` stores an optional URI for token metadata.
4. `pub extension: T` allows for custom token data.

```rust
#[derive(Serialize, Deserialize, Clone, PartialEq, JsonSchema, Debug)]
pub struct Approval {
    pub spender: Addr,
    pub expires: Expiration,
}

impl Approval {
    pub fn is_expired(&self, block: &BlockInfo) -> bool {
        self.expires.is_expired(block)
    }
}

```

This defines the `Approval` struct and its implementation:

1. `pub spender: Addr` stores the address approved to spend the token.
2. `pub expires: Expiration` stores when the approval expires.
3. The `is_expired` method checks if the approval has expired.

### Custom State for Fine Art Tokenization

Now, let's add our custom state fields for the Fine Art Tokenization dApp. Add the following code to the `src/state.rs` file:

```rust
pub struct Cw721Contract<'a, T, C>
where
    T: Serialize + DeserializeOwned + Clone,
    C: CustomMsg,
{
    // ... (existing fields)

    // Add these new fields
    pub token_uri: Item<'a, Option<String>>,
    pub(crate) _custom_response: PhantomData<C>,
    pub minting_allowed: Item<'a, bool>,
    pub max_mints: Item<'a, u64>,
    pub mint_price: Item<'a, Coin>,
}

```

Let's break down these custom additions:

1. `pub token_uri: Item<'a, Option<String>>` stores a single URI for all tokens in the collection.
2. `pub(crate) _custom_response: PhantomData<C>` is a placeholder for potential custom responses.
3. `pub minting_allowed: Item<'a, bool>` controls whether minting is currently allowed.
4. `pub max_mints: Item<'a, u64>` sets the maximum number of tokens that can be minted.
5. `pub mint_price: Item<'a, Coin>` stores the price to mint a new token.

![Screenshot 2024-09-26 at 4.48.48 PM.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%208%20Defining%20Messages%20and%20State%20-%20The%20Blueprint/Screenshot_2024-09-26_at_4.48.48_PM.webp?raw=true)

Add the following code to the `src/state.rs` file:

```rust
impl<T, C> Default for Cw721Contract<'static, T, C>
where
    T: Serialize + DeserializeOwned + Clone,
    C: CustomMsg,
{
    fn default() -> Self {
        Self {
            contract_info: Item::new("contract_info"),
            minter: Item::new("minter"),
            token_count: Item::new("num_tokens"),
            tokens: IndexedMap::new("tokens", TokenIndexes {
                owner: MultiIndex::new(token_owner_idx, "tokens", "tokens__owner"),
            }),
            operators: Map::new("operators"),
            _custom_response: PhantomData,
            minting_allowed: Item::new("minting_allowed"),
            max_mints: Item::new("max_mints"),
            mint_price: Item::new("mint_price"),
            token_uri: Item::new("token_uri"),
        }
    }
}

```

This `Default` implementation:

1. Provides default values for all state items.
2. Uses `Item::new()` to create new storage items with specific keys.
3. Initializes the custom fields we added.

![Screenshot 2024-09-26 at 4.49.18 PM.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%208%20Defining%20Messages%20and%20State%20-%20The%20Blueprint/Screenshot_2024-09-26_at_4.49.18_PM.webp?raw=true)

Add the following code to the `src/state.rs` file:

```rust
impl<'a, T, C> Cw721Contract<'a, T, C>
where
    T: Serialize + DeserializeOwned + Clone,
    C: CustomMsg,
{
  fn new(
        contract_key: &'a str,
        minter_key: &'a str,
        token_count_key: &'a str,
        operator_key: &'a str,
        tokens_key: &'a str,
        tokens_owner_key: &'a str,
    ) -> Self {
        let indexes = TokenIndexes {
            owner: MultiIndex::new(token_owner_idx, tokens_key, tokens_owner_key),
        };
        Self {
            contract_info: Item::new(contract_key),
            minter: Item::new(minter_key),
            token_count: Item::new(token_count_key),
            operators: Map::new(operator_key),
            tokens: IndexedMap::new(tokens_key, indexes),
            _custom_response: PhantomData,
            minting_allowed: Item::new("minting_allowed"),
            max_mints: Item::new("max_mints"),
            mint_price: Item::new("mint_price"),
            token_uri: Item::new("token_uri"),
        }
    }
    
    pub fn token_count(&self, storage: &dyn Storage) -> StdResult<u64> {
        Ok(self.token_count.may_load(storage)?.unwrap_or_default())
    }

    pub fn update_token_count(&self, storage: &mut dyn Storage, increment: bool) -> StdResult<u64> {
        let mut current_count = self.token_count(storage)?;
        if increment {
            current_count += 1;
        } else {
            current_count -= 1;
        }
        self.token_count.save(storage, &current_count)?;
        Ok(current_count)
    }
}

```

These methods manage the token count:

1. The `new` method is a constructor for the `Cw721Contract` struct that initializes a new instance of the contract with specified storage keys. It creates all necessary storage items, including contract info, minter address, token count, operators, tokens, and custom fields for minting control and NFT metadata. This method provides flexibility in contract initialization, which can be beneficial for upgrades or customizations.
2. `token_count` retrieves the current token count from storage.
3. `update_token_count` increments or decrements the token count based on the `increment` parameter.

Add the following code to the `src/state.rs` file:

```rust
pub struct TokenIndexes<'a, T>
where
    T: Serialize + DeserializeOwned + Clone,
{
    pub owner: MultiIndex<'a, Addr, TokenInfo<T>, Addr>,
}

impl<'a, T> IndexList<TokenInfo<T>> for TokenIndexes<'a, T>
where
    T: Serialize + DeserializeOwned + Clone,
{
    fn get_indexes(&'_ self) -> Box<dyn Iterator<Item = &'_ dyn Index<TokenInfo<T>>> + '_> {
        let v: Vec<&dyn Index<TokenInfo<T>>> = vec![&self.owner];
        Box::new(v.into_iter())
    }
}

pub fn token_owner_idx<T>(d: &TokenInfo<T>) -> Addr {
    d.owner.clone()
}

```

These structures and functions handle token indexing:

1. `TokenIndexes` defines an index for tokens by owner.
2. The `IndexList` implementation provides the necessary indexing functionality.
3. `token_owner_idx` is a helper function that returns the owner's address for a given token.

![Screenshot 2024-09-26 at 4.50.03 PM.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%208%20Defining%20Messages%20and%20State%20-%20The%20Blueprint/Screenshot_2024-09-26_at_4.50.03_PM.webp?raw=true)

These custom state fields allow our contract to manage fine art-specific data like minting controls and pricing, which are crucial for our tokenized art collection. They provide the necessary flexibility to implement features like limited edition releases, dynamic pricing, and detailed metadata management for our fine art NFTs.

## Quick Check Point

Update your code to the forked GitHub Repository using the following commands: 

```bash
git add .
git commit -m "updated state.rs and msg.rs"
git push
```

## Wrap Up

In this lesson, we've defined the messages and state for our Fine Art Tokenization dApp. We've built upon the standard CW721 implementation, adding custom functionality for minting control, pricing, and NFT details. These definitions in `msg.rs` and `state.rs` form the backbone of our contract, specifying how it can be interacted with and what data it maintains.

By clearly separating standard CW721 elements from our custom additions, we ensure our contract remains compatible with the CW721 standard while incorporating the unique features of our Fine Art Tokenization dApp.

In the next lesson, we'll dive into the `execute.rs` file, where we'll implement the logic for these messages, bringing our NFT contract to life. We'll see how to use the state we've defined and how to process the custom messages we've created, turning our blueprint into a fully functional smart contract for tokenized fine art.