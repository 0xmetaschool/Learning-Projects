# Implementing Minting Logic in execute.rs

Welcome back, devs! In our last lesson, we laid out the blueprint for our Fine Art Tokenization dApp. Now, it's time to bring those plans to life by implementing the core logic in our `execute.rs` file.

Today, we're going to focus on the heart of our NFT contract: the minting process. We'll guide you through implementing key functions step-by-step, with opportunities for you to try your hand at coding along the way. You are almost at the end now, keep going, keep coding!!

## The Instantiate Function: Setting the Stage

Before we can mint NFTs, we need to set up our contract. The `instantiate` function is like preparing a blank canvas – it sets up everything we need to start creating.

In the boilerplate code provided, you'll find a placeholder for the `instantiate` function. Much of the standard CW721 initialization is already implemented. Our task is to add the specific parameters and logic needed for our Fine Art Tokenization dApp.

Now first think what additional information we need to start our NFT contract, specifically for tokenizing fine art? Consider what parameters might be important for minting and managing these special NFTs.

Try extending the existing `instantiate` function with these art-specific features. Here's a hint to get you started:

```solidity
pub fn instantiate(
    &self,
    deps: DepsMut,
    _env: Env,
    _info: MessageInfo,
    msg: InstantiateMsg,
) -> StdResult<Response<C>> {
    // Existing CW721 initialization code...

    // TODO: Initialize minting parameters (allowed, max mints, price)
    // TODO: Save token URI for the art collection
    // Any other art-specific initializations?

    Ok(Response::default())
}
```

Focus on adding the TODOs and any other initializations you think might be necessary for our fine art NFTs. Don't worry if you're not sure about everything – we'll go through it together!

Now, let's look at the complete implementation (update the `instantiate` function accordingly):

```solidity
pub fn instantiate(
    &self,
    deps: DepsMut,
    _env: Env,
    _info: MessageInfo,
    msg: InstantiateMsg,
) -> StdResult<Response<C>> {
    set_contract_version(deps.storage, CONTRACT_NAME, CONTRACT_VERSION)?;

    let info = ContractInfoResponse {
        name: msg.name,
        symbol: msg.symbol,
    };
    self.contract_info.save(deps.storage, &info)?;
    let minter = deps.api.addr_validate(&msg.minter)?;
    self.minter.save(deps.storage, &minter)?;
    self.minting_allowed.save(deps.storage, &true)?;
    self.max_mints.save(deps.storage, &msg.max_mints)?;
    self.mint_price.save(deps.storage, &msg.mint_price)?;
    self.token_uri.save(deps.storage, &msg.token_uri)?;
    Ok(Response::default())
}
```

Let's break this down:

1. `set_contract_version(deps.storage, CONTRACT_NAME, CONTRACT_VERSION)?;`
This sets the contract's name and version, which is useful for future migrations.
2. `let info = ContractInfoResponse { name: msg.name, symbol: msg.symbol };`
We create this struct with the contract's name and symbol.
3. `self.contract_info.save(deps.storage, &info)?;`
This saves the contract info to storage.
4. `let minter = deps.api.addr_validate(&msg.minter)?;`
This validates the minter's address provided in the instantiation message.
5. `self.minter.save(deps.storage, &minter)?;`
This saves the validated minter address to storage.
6. `self.minting_allowed.save(deps.storage, &true)?;`
Initially sets minting as allowed (true).
7. `self.max_mints.save(deps.storage, &msg.max_mints)?;`
Saves the maximum number of mints allowed.
8. `self.mint_price.save(deps.storage, &msg.mint_price)?;`
Saves the price for minting a new token.
9. `self.token_uri.save(deps.storage, &msg.token_uri)?;`
Saves the token URI for the collection.
10. `Ok(Response::default())`
Returns a default response indicating successful instantiation.
    
    ![Screenshot 2024-09-26 at 4.53.57 PM.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%209%20Implementing%20Minting%20Logic%20in%20execute/Screenshot_2024-09-26_at_4.53.57_PM.webp?raw=true)
    

This function sets up the initial state of our contract, including crucial parameters for the minting process.

## The Execute Function: Traffic Control for Our Contract

The `execute` function is like a traffic controller, directing different types of messages to the right place. What types of actions do you think our NFT contract needs to handle? Consider minting, but also think about what else we might need to manage our NFTs.

Try writing the structure of the `execute` function. Here's a starting point:

```rust
pub fn execute(
    &self,
    deps: DepsMut,
    env: Env,
    info: MessageInfo,
    msg: ExecuteMsg<T>,
) -> Result<Response<C>, ContractError> {
    match msg {
        // TODO: Add cases for different message types
        // ... other ExecuteMsg variants
    }
}

```

Now, let's look at the complete implementation:

```rust
pub fn execute(
    &self,
    deps: DepsMut,
    env: Env,
    info: MessageInfo,
    msg: ExecuteMsg<T>,
) -> Result<Response<C>, ContractError> {
    match msg {
        ExecuteMsg::Mint(msg) => self.mint(deps, env, info, msg),
        ExecuteMsg::SetMintConfig { price, max_mints } => {
	        self.set_mint_config(deps, info, price, max_mints)
        }
        ExecuteMsg::ToggleMinting {} => self.toggle_minting(deps, info),
        // ... other ExecuteMsg variants (already implemented in boilerplate)
    }
}

```

This function acts as a router for different types of messages:

- It uses a `match` statement to determine which specific function to call based on the `ExecuteMsg` variant.
- For `ExecuteMsg::Mint`, it calls the `self.mint` function. This handles the minting of new NFTs.
- For `ExecuteMsg::SetMintConfig`, it calls the `self.set_mint_config` function. This allows the admin to update the minting price and maximum number of mints. It passes the `price` and `max_mints` parameters received in the message.
- For `ExecuteMsg::ToggleMinting`, it calls the `self.toggle_minting` function. This enables the admin to turn minting on or off.
- Other variants (like `Approve`, `Revoke`, etc.) are already implemented in the boilerplate.
    
    ![Screenshot 2024-09-26 at 4.55.08 PM.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%209%20Implementing%20Minting%20Logic%20in%20execute/Screenshot_2024-09-26_at_4.55.08_PM.webp?raw=true)
    

This structure allows us to easily add new message types and their corresponding handler functions as our contract grows.

## The Mint Function: Creating Digital Art

Now for the exciting part – the function that actually creates our NFTs! The `mint` function is where the magic happens. What checks do we need to perform before minting an NFT? What information do we need to store for each NFT?

Try sketching out the `mint` function. Here's a pseudo-code structure to get you started:

```rust
pub fn mint(
    &self,
    deps: DepsMut,
    _env: Env,
    info: MessageInfo,
    msg: MintMsg<T>,
) -> Result<Response<C>, ContractError> {
    // TODO: Check if minting is allowed
    // TODO: Check if we've reached max mints
    // TODO: Verify correct payment
    // TODO: Create and store the new token
    // TODO: Update total token count
    // TODO: Return success response
}

```

Now, let's look at the complete implementation:

```rust
pub fn mint(
    &self,
    deps: DepsMut,
    _env: Env,
    info: MessageInfo,
    msg: MintMsg<T>,
) -> Result<Response<C>, ContractError> {
    // Check if minting is allowed
    let minting_allowed = self.minting_allowed.load(deps.storage)?;
    if !minting_allowed {
        return Err(ContractError::MintingDisabled {});
    }

    // Check if there are mints left
    let token_count = self.token_count(deps.storage)?;
    let max_mints = self.max_mints.load(deps.storage)?;
    if token_count >= max_mints {
        return Err(ContractError::MaxMintsReached {});
    }

    // Check payment
    let price = self.mint_price.load(deps.storage)?;
    if info.funds.len() != 1 || info.funds[0] != price {
        return Err(ContractError::IncorrectPayment {});
    }

    // Retrieve the token_uri from storage
    let token_uri = self.token_uri.load(deps.storage)?;

    // create the token
    let token = TokenInfo {
        owner: deps.api.addr_validate(&msg.owner)?,
        approvals: vec![],
        token_uri,
        extension: msg.extension,
    };
    self.tokens
        .update(deps.storage, &token_count.to_string(), |old| match old {
            Some(_) => Err(ContractError::Claimed {}),
            None => Ok(token),
        })?;

    self.update_token_count(deps.storage, true)?;

    Ok(Response::new()
        .add_attribute("action", "mint")
        .add_attribute("minter", info.sender)
        .add_attribute("token_id", token_count.to_string()))
}

```

Let's break this down step by step:

1. Check if minting is allowed:
    - We load the `minting_allowed` flag from storage.
    - If minting is not allowed, we return an error.
2. Check if there are mints left:
    - We get the current token count and the maximum allowed mints.
    - If we've reached the maximum, we return an error.
3. Check payment:
    - We load the mint price from storage.
    - We verify that exactly one coin was sent and that it matches the required price.
4. Retrieve the token URI:
    - We load the token URI from storage. This is the same for all tokens in our collection.
5. Create the token:
    - We create a new `TokenInfo` struct with the owner's address, an empty list of approvals, the token URI, and any additional extension data.
6. Save the token:
    - We use the `update` method on `self.tokens` to save the new token.
    - The `update` method first checks if a token with this ID already exists. If it does, it returns an error (Claimed). If not, it saves the new token.
7. Update the token count:
    - We call `update_token_count` to increment the total number of tokens.
8. Return a success response:
    - We create a `Response` with attributes indicating the action (mint), the minter's address, and the new token's ID.

This function encapsulates the core logic of creating a new NFT, including all necessary checks and updates to the contract's state.

Let’s add two more functions `set_mint_config` and `toggle_minting` :

```solidity

    fn set_mint_config(
        &self,
        deps: DepsMut,
        info: MessageInfo,
        price: Coin,
        max_mints: u64,
    ) -> Result<Response<C>, ContractError> {
        // Only the minter (admin) can set the mint configuration
        let minter = self.minter.load(deps.storage)?;
        if info.sender != minter {
            return Err(ContractError::Unauthorized {});
        }
        self.mint_price.save(deps.storage, &price)?;
        self.max_mints.save(deps.storage, &max_mints)?;

        Ok(Response::new()
            .add_attribute("action", "set_mint_config")
            .add_attribute("price", price.to_string())
            .add_attribute("max_mints", max_mints.to_string()))
    }

    fn toggle_minting(
        &self,
        deps: DepsMut,
        info: MessageInfo,
    ) -> Result<Response<C>, ContractError> {
        let minter = self.minter.load(deps.storage)?;

        if info.sender != minter {
            return Err(ContractError::Unauthorized {});
        }

        let mut minting_allowed = self.minting_allowed.load(deps.storage)?;
        minting_allowed = !minting_allowed;
        self.minting_allowed.save(deps.storage, &minting_allowed)?;

        Ok(Response::new()
            .add_attribute("action", "toggle_minting")
            .add_attribute("minting_allowed", minting_allowed.to_string()))
    }
   
```

### `set_mint_config` function:

This function allows the contract admin (minter) to update the minting configuration.

```rust
fn set_mint_config(
    &self,
    deps: DepsMut,
    info: MessageInfo,
    price: Coin,
    max_mints: u64,
) -> Result<Response<C>, ContractError>

```

- It takes the new minting price and maximum number of mints as parameters.
- It first checks if the sender is the authorized minter (admin).
- If authorized, it updates the `mint_price` and `max_mints` in storage.
- It returns a response with attributes indicating the action and new values.

This function is crucial for adjusting the economics of the NFT collection, allowing the admin to change the minting price or adjust the total supply cap as needed.

### `toggle_minting` function:

This function allows the contract admin to enable or disable minting.

```rust
fn toggle_minting(
    &self,
    deps: DepsMut,
    info: MessageInfo,
) -> Result<Response<C>, ContractError>

```

- It first verifies that the sender is the authorized minter (admin).
- If authorized, it loads the current `minting_allowed` status from storage.
- It then toggles this status (true becomes false, false becomes true).
- The new status is saved back to storage.
- It returns a response with attributes indicating the action and new minting status.

This function provides control over when minting can occur, which can be useful for managing release phases or pausing minting if issues arise.

Both of these functions add important administrative controls to the NFT contract, allowing for flexible management of the minting process and collection parameters. They ensure that only the authorized admin can make these critical changes, maintaining the integrity and controlled growth of the NFT collection.

## Quick Check Point

Update your code to the forked GitHub Repository using the following commands: 

```bash
git add .
git commit -m "updated execute.rs"
git push
```

## Wrap up and Next Steps

Congratulations! You've just implemented the core minting logic for your Fine Art Tokenization dApp.

In our next lesson, we'll explore how to query our contract state, allowing users to retrieve information about our NFT collection. This will complete the core functionality of our dApp.

Remember, the world of NFTs is all about creativity – both in the art itself and in the smart contracts that power them. Keep experimenting and happy coding!