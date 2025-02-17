# Diving into CW721 - The Building Block of Our Tokenization dApp

Hey there, great to see that you have made it to Lesson 5! Are you ready to peek under the hood of our Mona Lisa NFT dApp? Today, we're going to explore the magic ingredient that makes our digital Mona Lisa possible: CW721. Don't worry if you're not a coding wizard - we'll keep things simple and fun!

## What is CW721?

Imagine you're building a house. You need a solid foundation, right? Well, in the world of NFTs on the MANTRA Chain, CW721 is that foundation. It's like a set of blueprints that tells us how to create, manage, and trade NFTs. You wouldn't build a house without a plan, and we wouldn't create NFTs without CW721!

CW721 is a standard for non-fungible tokens (NFTs) in the CosmWasm ecosystem. Think of it as a recipe that everyone agrees to follow when making NFTs. This way, all NFTs speak the same language, making them easy to trade and use across different platforms. It's a bit like how all cars have a steering wheel, accelerator, and brake pedal in the same places - it makes it easy for anyone to drive any car.

## What Can CW721 Do?

![Ocean Protocol (16).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%205%20Diving%20into%20CW721%20-%20The%20Building%20Block/Ocean_Protocol_(16).webp?raw=true)

CW721 is pretty powerful. Here's what it brings to the table:

1. **Minting**: It allows us to create new NFTs. In our case, it's how we'll bring new Mona Lisa NFTs into existence. It's like a digital printing press for our artwork.
2. **Ownership**: It keeps track of who owns each NFT. So we always know whose digital wallet our Mona Lisa pieces are in. Imagine if the Louvre had a magical system that always knew where every piece of art was - that's what CW721 does for our digital Mona Lisa.
3. **Transferring**: It lets NFT owners send their tokens to others. Want to gift your friend a piece of the Mona Lisa? CW721 makes it possible! It's like having a secure courier service built right into each NFT.
4. **Burning**: If someone decides they don't want their NFT anymore, CW721 allows for "burning" or destroying the token. It's the digital equivalent of throwing a painting into a fire - dramatic, but sometimes necessary!
5. **Metadata**: It stores information about each NFT, like its name, description, and image link. This is like attaching a detailed museum label to each piece of our digital Mona Lisa.

## Let's Look at Some Code!

Now, let's dive into the heart of CW721 and explore its main functions. Don't worry if some of this looks complex - we'll break it down step by step!

Before we get into the specifics, it's important to remember that CW721 provides a blueprint that everyone has to follow. Think of it like a set of building codes for a house. You can add extra rooms or fancy decorations, but the basic structure needs to meet certain standards. 

In the same way, when we use CW721, we can add our own custom functionalities, but we must adhere to the core blueprint it provides. This ensures that all NFTs built with CW721 will work together smoothly, no matter who created them or what blockchain they're on.

In the CW721 package, there's a file called `traits.rs`. In Rust, traits are like a collection of methods that types can implement. They're similar to interfaces in other programming languages. Traits define a set of behaviors that a type must have to implement that trait. In the context of CW721, traits define the standard behaviors that any CW721-compliant NFT contract must implement.

### Now, let's break down the `Cw721Execute` trait

```rust
pub trait Cw721Execute<T, C>
where
    T: Serialize + DeserializeOwned + Clone,
    C: CustomMsg,
{
    type Err: ToString;

    // Function definitions...
}

```

This defines a trait named `Cw721Execute` with two generic parameters:

- `T`: This represents the type of the token's metadata. It must be serializable, deserializable, and clonable.
- `C`: This is for custom messages that can be added to the contract.

The `where` clause specifies constraints on these generic types.

`type Err: ToString;` defines an associated type `Err` that must implement the `ToString` trait. This is used for error handling.

Now, let's look at each function in this trait:

1. `transfer_nft`:
    
    ```rust
    fn transfer_nft(
        &self,
        deps: DepsMut,
        env: Env,
        info: MessageInfo,
        recipient: String,
        token_id: String,
    ) -> Result<Response<C>, Self::Err>;
    
    ```
    
    This function transfers an NFT from one owner to another. It takes the recipient's address and the token ID as parameters.
    
2. `send_nft`:
    
    ```rust
    fn send_nft(
        &self,
        deps: DepsMut,
        env: Env,
        info: MessageInfo,
        contract: String,
        token_id: String,
        msg: Binary,
    ) -> Result<Response<C>, Self::Err>;
    
    ```
    
    Similar to `transfer_nft`, but it sends the NFT to a contract along with a message. This allows for more complex interactions between contracts.
    
3. `approve`:
    
    ```rust
    fn approve(
        &self,
        deps: DepsMut,
        env: Env,
        info: MessageInfo,
        spender: String,
        token_id: String,
        expires: Option<Expiration>,
    ) -> Result<Response<C>, Self::Err>;
    
    ```
    
    This function approves another address (the spender) to transfer a specific NFT. It can include an expiration for the approval.
    
4. `revoke`:
    
    ```rust
    fn revoke(
        &self,
        deps: DepsMut,
        env: Env,
        info: MessageInfo,
        spender: String,
        token_id: String,
    ) -> Result<Response<C>, Self::Err>;
    
    ```
    
    This revokes a previous approval for a specific NFT.
    
5. `approve_all`:
    
    ```rust
    fn approve_all(
        &self,
        deps: DepsMut,
        env: Env,
        info: MessageInfo,
        operator: String,
        expires: Option<Expiration>,
    ) -> Result<Response<C>, Self::Err>;
    
    ```
    
    This approves an operator to transfer all of the owner's NFTs. It's like a blanket approval.
    
6. `revoke_all`:
    
    ```rust
    fn revoke_all(
        &self,
        deps: DepsMut,
        env: Env,
        info: MessageInfo,
        operator: String,
    ) -> Result<Response<C>, Self::Err>;
    
    ```
    
    This revokes the blanket approval given by `approve_all`.
    
7. `burn`:
    
    ```rust
    fn burn(
        &self,
        deps: DepsMut,
        env: Env,
        info: MessageInfo,
        token_id: String,
    ) -> Result<Response<C>, Self::Err>;
    
    ```
    
    This function destroys (burns) an NFT, removing it from circulation permanently.
    

All these functions follow a similar pattern:

- They take `&self` (a reference to the contract instance), `deps: DepsMut` (mutable dependencies for interacting with the blockchain), `env: Env` (environment variables), and `info: MessageInfo` (information about the message sender).
- They return a `Result` type, which is either a `Response<C>` (successful operation with optional custom messages) or an error.

This trait defines the core functionality that any CW721-compliant NFT contract must implement. It provides a standardized way to transfer, approve, and manage NFTs, ensuring interoperability across different implementations.

## Now, let's examine the `Cw721Query` trait

```rust
pub trait Cw721Query<T>
where
    T: Serialize + DeserializeOwned + Clone,
{
    // Function definitions...
}

```

This trait defines the query functions for a CW721-compliant NFT contract. The generic parameter `T` represents the type of the token's metadata, which must be serializable, deserializable, and clonable.

Let's break down each function in this trait:

1. `contract_info`:
    
    ```rust
    fn contract_info(&self, deps: Deps) -> StdResult<ContractInfoResponse>;
    ```
    
    This function returns general information about the NFT contract, such as its name and symbol.
    
2. `num_tokens`:
    
    ```rust
    fn num_tokens(&self, deps: Deps) -> StdResult<NumTokensResponse>;
    ```
    
    This returns the total number of NFTs minted by the contract.
    
3. `nft_info`:
    
    ```rust
    fn nft_info(&self, deps: Deps, token_id: String) -> StdResult<NftInfoResponse<T>>;
    ```
    
    This function retrieves the metadata associated with a specific NFT, identified by its token ID.
    
4. `owner_of`:
    
    ```rust
    fn owner_of(
        &self,
        deps: Deps,
        env: Env,
        token_id: String,
        include_expired: bool,
    ) -> StdResult<OwnerOfResponse>;
    ```
    
    This returns the current owner of a specific NFT. The `include_expired` parameter determines whether to include expired approvals in the response.
    
5. `operators`:
    
    ```rust
    fn operators(
        &self,
        deps: Deps,
        env: Env,
        owner: String,
        include_expired: bool,
        start_after: Option<String>,
        limit: Option<u32>,
    ) -> StdResult<OperatorsResponse>;
    ```
    
    This function lists all operators (addresses approved to transfer all of an owner's tokens) for a given owner. It supports pagination through `start_after` and `limit` parameters.
    
6. `approval`:
    
    ```rust
    fn approval(
        &self,
        deps: Deps,
        env: Env,
        token_id: String,
        spender: String,
        include_expired: bool,
    ) -> StdResult<ApprovalResponse>;
    ```
    
    This checks if a specific spender is approved to transfer a particular NFT.
    
7. `approvals`:
    
    ```rust
    fn approvals(
        &self,
        deps: Deps,
        env: Env,
        token_id: String,
        include_expired: bool,
    ) -> StdResult<ApprovalsResponse>;
    ```
    
    This returns all approvals for a specific NFT.
    
8. `tokens`:
    
    ```rust
    fn tokens(
        &self,
        deps: Deps,
        owner: String,
        start_after: Option<String>,
        limit: Option<u32>,
    ) -> StdResult<TokensResponse>;
    ```
    
    This function lists all tokens owned by a specific address.
    
9. `all_tokens`:
    
    ```rust
    fn all_tokens(
        &self,
        deps: Deps,
        start_after: Option<String>,
        limit: Option<u32>,
    ) -> StdResult<TokensResponse>;
    ```
    
    This lists all tokens in the contract, regardless of owner.
    
10. `all_nft_info`:
    
    ```rust
    fn all_nft_info(
        &self,
        deps: Deps,
        env: Env,
        token_id: String,
        include_expired: bool,
    ) -> StdResult<AllNftInfoResponse<T>>;
    ```
    
    This function combines `nft_info` and `owner_of`, returning both the token's metadata and ownership information in a single query.
    

All these functions follow a similar pattern:

- They take `&self` (a reference to the contract instance) and `deps: Deps` (dependencies for reading from the blockchain).
- Some functions also take `env: Env` for environment information.
- They return a `StdResult` type, which is either a specific response type or an error.

This trait defines all the query operations that a CW721-compliant NFT contract must support. These functions allow users and other contracts to retrieve information about the NFTs, their owners, and the overall state of the contract. By standardizing these query functions, CW721 ensures that all compliant NFT contracts can be interacted with in a consistent manner, regardless of their specific implementation details.

## Extending CW721 for Our Mona Lisa NFT

Now that we've explored the core functionality provided by CW721, it's important to understand that this is just our starting point. Think of CW721 as the foundation of a house - it gives us the essential structure, but we can build upon it to create something unique. 

For our Mona Lisa NFT project, we'll be adding our own custom functionality on top of this CW721 base. We'll implement features specific to our needs, such as limiting the total number of NFTs that can be minted, setting a minting price, and including special metadata about each Mona Lisa piece. 

This is the beauty of using a standard like CW721 - it provides a solid, well-tested base that ensures our NFTs will be compatible with other systems, while still allowing us the flexibility to customize and add features that make our Mona Lisa NFTs special and unique. In the next lesson, we'll dive into these custom additions and see how we can tailor CW721 to perfectly fit our digital Mona Lisa project.

## Wrap Up

In this lesson, we've explored CW721, the standard for creating NFTs in the CosmWasm ecosystem. We've learned about its core functions, including how to transfer NFTs, approve others to use them, and query information about them. We've seen how CW721 provides a solid foundation for NFT contracts while allowing for customization to fit specific needs like our Mona Lisa project.

In the next lesson, we'll move from theory to practice. We'll look at the tools and setup required to start building our Mona Lisa NFT contract. We'll cover the development environment and the specific tools we'll be using. This will prepare us to start coding our own NFT contract based on the CW721 standard.