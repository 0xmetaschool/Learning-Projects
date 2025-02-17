# Understanding helpers.rs in Our Fine Art Tokenization dApp

Hey devs, in this lesson, we'll explore the `helpers.rs` file, a crucial component of our Fine Art Tokenization dApp's smart contract. Before we dive in, it's important to understand a key point:

**Note**: While `helpers.rs` provides methods for querying our smart contract, the actual implementation of these queries is in `query.rs`. The `helpers.rs` file provides a convenient interface for calling these queries, acting as a bridge between our contract and external interactions.

The `helpers.rs` file serves several important purposes in our smart contract:

1. **Query Interface**: It defines methods that correspond to the queries implemented in `query.rs`, providing a user-friendly way to interact with our contract.
2. **Contract Abstraction**: It defines a `Cw721Contract` struct, providing a high-level interface for interacting with our NFT contract.
3. **Standardization**: By implementing these helper functions, our contract adheres to the CW721 standard, ensuring interoperability within the CosmWasm ecosystem.
4. **Code Reusability**: These helpers can be used across different parts of our smart contract, promoting code reuse and reducing the chance of errors.
5. **Testing Support**: The helper functions are particularly useful for writing unit tests for our contract.

In this lesson, we'll examine the structure of `helpers.rs`, focusing on the query methods most relevant to our Fine Art Tokenization dApp. We'll also touch on other available queries that, while not currently used in our frontend, are part of the standard CW721 implementation and could be useful for future extensions of our dApp.

## Structure of Cw721Contract

Let's look at the basic structure of the `Cw721Contract` in `helpers.rs`:

```rust
#[derive(Serialize, Deserialize, Clone, Debug, PartialEq)]
pub struct Cw721Contract(pub Addr);

impl Cw721Contract {
    pub fn addr(&self) -> Addr {
        self.0.clone()
    }

    // Query and execute functions will be implemented here
}

```

This struct represents our NFT contract and will contain all the helper methods for interacting with it.

## Key Query Methods

While `helpers.rs` provides many query methods, we'll focus on the ones most relevant to our Fine Art Tokenization dApp:

### 1. contract_info

This query retrieves basic information about our NFT contract.

```rust
pub fn contract_info(&self, querier: &QuerierWrapper) -> StdResult<ContractInfoResponse> {
    let req = QueryMsg::ContractInfo {};
    self.query(querier, req)
}

```

This function is used in our frontend to get the name and symbol of our NFT collection.

### 2. num_tokens

This query returns the total number of tokens minted in our contract.

```rust
pub fn num_tokens(&self, querier: &QuerierWrapper) -> StdResult<u64> {
    let req = QueryMsg::NumTokens {};
    let res: NumTokensResponse = self.query(querier, req)?;
    Ok(res.count)
}

```

We use this in our frontend to display the total number of NFTs minted so far.

### 3. nft_info

This query retrieves metadata for a specific NFT.

```rust
pub fn nft_info<T: Into<String>, U: DeserializeOwned>(
    &self,
    querier: &QuerierWrapper,
    token_id: T,
) -> StdResult<NftInfoResponse<U>> {
    let req = QueryMsg::NftInfo {
        token_id: token_id.into(),
    };
    self.query(querier, req)
}

```

This function is crucial for displaying information about individual NFTs in our dApp.

## Custom Query: nft_details

While not part of the standard `helpers.rs`, our dApp uses a custom `nft_details` query. This query is specific to our Fine Art Tokenization dApp and retrieves important details about our NFT collection.

```rust
pub fn nft_details(&self, querier: &QuerierWrapper) -> StdResult<NftDetailsResponse> {
    let req = QueryMsg::NftDetails {};
    self.query(querier, req)
}

```

This query returns information such as the token URI, minting price, and maximum number of mints allowed.

## Other Available Queries

The `helpers.rs` file also provides several other query methods that are part of the standard CW721 implementation. While we're not actively using these in our current frontend, they're available for future extensions of our dApp:

- `owner_of`: Gets the owner of a specific token
- `approval`: Checks if a specific address is approved to transfer a token
- `approvals`: Lists all approvals for a token
- `all_operators`: Lists all operators for a given owner
- `tokens`: Lists tokens owned by a given address
- `all_tokens`: Lists all tokens in the contract
- `all_nft_info`: Gets both ownership and metadata information for an NFT

## Wrap Up

The `helpers.rs` file plays a crucial role in our Fine Art Tokenization dApp by providing a standardized interface for interacting with our NFT contract. While it offers a wide range of functionalities as part of the CW721 standard, we've focused on the queries most relevant to our current implementation: `contract_info`, `num_tokens`, `nft_info`, and our custom `nft_details` query.

Understanding these helpers is key to effectively working with our smart contract, whether you're developing the contract itself, writing tests, or building frontend applications that interact with the contract.

As you continue to develop your dApp, remember that you have a rich set of additional queries at your disposal in `helpers.rs`. These can be leveraged to add new features and functionalities to your Fine Art Tokenization platform in the future.