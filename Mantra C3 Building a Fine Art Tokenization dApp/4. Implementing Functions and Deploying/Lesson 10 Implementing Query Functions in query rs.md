# Implementing Query Functions in query.rs

Welcome back, NFT pioneers! In our last lesson, we implemented the core minting logic for our Fine Art Tokenization dApp. Now, it's time to enable users to retrieve information about our NFT collection. We'll do this by implementing query functions in our `query.rs` file.

In this lesson, we'll focus on implementing four key queries that are essential for our dApp's functionality:

1. `ContractInfo`
2. `NumTokens`
3. `NftInfo`
4. `NftDetails`

Remember, some standard CW721 queries are already implemented in the boilerplate. We'll be adding to these to create functionality specific to our fine art NFTs.

## The Query Function: Our Information Hub

Before we dive into specific queries, let's look at the main `query` function. This function, like our `execute` function from the last lesson, acts as a router for different types of query messages.

In your `query.rs` file, you'll find a placeholder for the `query` function on line number `223`. Try to implement it based on what you learned in the last lesson. Here's a starting point:

```rust
pub fn query(&self, deps: Deps, env: Env, msg: QueryMsg) -> StdResult<Binary> {
    match msg {
	    QueryMsg::ContractInfo {} => to_json_binary(&self.contract_info(deps)?),
	    QueryMsg::NftInfo { token_id } => to_json_binary(&self.nft_info(deps, token_id)?),
        // TODO: Add cases for different query types
        // Hint: Think about the four queries we mentioned
        
        // ... other QueryMsg variants (already implemented in boilerplate)
    }
}

```

Now, let's look at the complete implementation:

```rust
pub fn query(&self, deps: Deps, env: Env, msg: QueryMsg) -> StdResult<Binary> {
    match msg {
        QueryMsg::ContractInfo {} => to_json_binary(&self.contract_info(deps)?),
        QueryMsg::NftInfo { token_id } => to_json_binary(&self.nft_info(deps, token_id)?),
        QueryMsg::AllNftInfo {
            token_id,
            include_expired,
        } => to_json_binary(&self.all_nft_info(
            deps,
            env,
            token_id,
            include_expired.unwrap_or(false),
        )?),
        QueryMsg::NumTokens {} => to_json_binary(&self.num_tokens(deps)?),
        QueryMsg::NftDetails {} => to_json_binary(&self.nft_details(deps)?),
        // ... other QueryMsg variants (already implemented in boilerplate)
    }
}

```

This function matches on the `QueryMsg` variant and calls the appropriate query function. It then wraps the result in a `Binary` format using `to_json_binary`. This is necessary because the blockchain expects query responses in this format.

![Screenshot 2024-09-26 at 4.57.33 PM.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%2010%20Implementing%20Query%20Functions%20in%20query/Screenshot_2024-09-26_at_4.57.33_PM.webp?raw=true)

Now, let's implement each of our custom query functions.

### ContractInfo Query

The `ContractInfo` query returns basic information about our NFT contract. Try implementing this function. Here's a hint to get you started:

```rust
fn contract_info(&self, deps: Deps) -> StdResult<ContractInfoResponse> {
    // TODO: Load contract info from storage and return it
}

```

Now, let's look at the complete implementation:

```rust
fn contract_info(&self, deps: Deps) -> StdResult<ContractInfoResponse> {
    self.contract_info.load(deps.storage)
}

```

Let's break this down:

1. `fn contract_info(&self, deps: Deps) -> StdResult<ContractInfoResponse>`: This defines a function that takes a reference to `self` and `deps` (dependencies, including storage), and returns a `StdResult` containing a `ContractInfoResponse`.
2. `self.contract_info.load(deps.storage)`: This loads the contract info from storage. The `load` function returns a `StdResult`, which is directly returned from our function.

This function simply retrieves the stored contract information, which typically includes the name and symbol of the NFT collection.

## NumTokens Query

The `NumTokens` query returns the total number of tokens minted. Try implementing this function. Here's a hint:

```rust
fn num_tokens(&self, deps: Deps) -> StdResult<NumTokensResponse> {
    // TODO: Get the token count from storage
    // TODO: Return the count wrapped in a NumTokensResponse
}

```

Now, let's look at the complete implementation:

```rust
fn num_tokens(&self, deps: Deps) -> StdResult<NumTokensResponse> {
    let count = self.token_count(deps.storage)?;
    Ok(NumTokensResponse { count })
}

```

Let's break this down:

1. `let count = self.token_count(deps.storage)?;`: This calls a helper function `token_count` to get the current number of tokens from storage. The `?` operator will return early if there's an error.
2. `Ok(NumTokensResponse { count })`: This wraps the count in a `NumTokensResponse` struct and returns it as an `Ok` result.

## NftInfo Query

The `NftInfo` query returns metadata about a specific NFT. Try implementing this function. Here's a hint:

```rust
fn nft_info(&self, deps: Deps, token_id: String) -> StdResult<NftInfoResponse<T>> {
    // TODO: Load the token info from storage
    // TODO: Return the token URI and extension data in an NftInfoResponse
}

```

Now, let's look at the complete implementation:

```rust
fn nft_info(&self, deps: Deps, token_id: String) -> StdResult<NftInfoResponse<T>> {
    let info = self.tokens.load(deps.storage, &token_id)?;
    Ok(NftInfoResponse {
        token_uri: info.token_uri,
        extension: info.extension,
    })
}

```

Let's break this down:

1. `let info = self.tokens.load(deps.storage, &token_id)?;`: This loads the token info from storage using the provided `token_id`. If the token doesn't exist, this will return an error.
2. `Ok(NftInfoResponse { token_uri: info.token_uri, extension: info.extension, })`: This creates an `NftInfoResponse` with the token's URI and any extension data, and returns it wrapped in `Ok`.

## NftDetails Query

The `NftDetails` query is specific to our Fine Art Tokenization dApp. It returns details about our NFT collection. Try implementing this function. Here's a hint:

```rust
pub fn nft_details(&self, deps: Deps) -> StdResult<NftDetailsResponse> {
    // TODO: Load mint price, max mints, and token URI from storage
    // TODO: Return these details in an NftDetailsResponse
}

```

Now, let's look at the complete implementation:

```rust
pub fn nft_details(&self, deps: Deps) -> StdResult<NftDetailsResponse> {
    let mint_price = self.mint_price.load(deps.storage)?;
    let max_mints = self.max_mints.load(deps.storage)?;
    let token_uri = self.token_uri.load(deps.storage)?;

    Ok(NftDetailsResponse {
        token_uri,
        mint_price,
        max_mints,
    })
}

```

Let's break this down:

1. `let mint_price = self.mint_price.load(deps.storage)?;`: This loads the minting price from storage.
2. `let max_mints = self.max_mints.load(deps.storage)?;`: This loads the maximum number of allowed mints from storage.
3. `let token_uri = self.token_uri.load(deps.storage)?;`: This loads the token URI for the collection from storage.
4. `Ok(NftDetailsResponse { token_uri, mint_price, max_mints, })`: This creates an `NftDetailsResponse` with all the loaded details and returns it wrapped in `Ok`.

Each of these lines uses the `?` operator, which will return early with an error if the loading operation fails.

## Quick Check Point

Update your code to the forked GitHub Repository using the following commands: 

```bash
git add .
git commit -m "updated query.rs"
git push
```

## Wrap up and Next Steps

Great job! You've now implemented the key query functions for your Fine Art Tokenization dApp. These functions will allow users to retrieve important information about your NFT collection, including:

1. Basic contract information
2. The total number of tokens minted
3. Metadata for specific NFTs
4. Details about the collection, including minting price and limits

Remember, there are other query functions implemented in the boilerplate that you can use to extend the functionality of your dApp. These include queries for ownership, approvals, and listings of tokens.

In our next lesson, we'll explore how to integrate these queries with your frontend, allowing users to interact with your smart contract and view information about your NFT collection.