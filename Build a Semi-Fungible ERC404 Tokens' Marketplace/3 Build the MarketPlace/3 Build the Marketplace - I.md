# Build the Marketplace - I

Welcome back, folks! Great work on creating the token using the DN404 token standard. In this lesson, we will start writing the code for our marketplace. Why wait? Let’s start!

## Create NFTMarketplace.sol

First of all, head back to your `erc404-nftmarketplace-boilerplate` hardhat project. Navigate to the `contracts/NFTMarketplace.sol` file. We will add the marketplace code in this file. If it is not created, create one like this:

![struct-2.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_erc404/3%20Build%20the%20MarketPlace/3%20Build%20the%20Marketplace%20-%20I/struct-2.webp?raw=true)

## Start Coding

Let’s start coding and create our `NFTMarketplace.sol` file.

### SPDX-License-Identifier and Pragma Directive

```
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;
```

- `SPDX-License-Identifier`: Specifies the license under which the source code is released. In this case, it's set to "UNLICENSED", indicating that the code has no specific licensing restrictions.
- `pragma solidity ^0.8.20;`: Specifies the Solidity compiler version to be used, indicating that the code is compatible with versions greater than or equal to 0.8.20.

### Import Statements

```
import "./Interface/IDN404.sol";
import "@openzeppelin/contracts/utils/Context.sol";
```

- `import "./Interface/IDN404.sol";`: Imports the interface for contract IDN404.sol located in the Interface directory.
- `import "@openzeppelin/contracts/utils/Context.sol";`: Imports the Context utility from the OpenZeppelin library, which provides contextual information about the current call.

### Error Declarations

```
error PriceNotMet(address nftAddress, uint256 price);
error ItemNotForSale(address nftAddress);
error NotListed(address nftAddress);
error AlreadyListed(address nftAddress);
error NoProceeds();
error NotOwner();
error NotApprovedForMarketplace();
error PriceMustBeAboveZero();
error NotApproved();
```

- Declares custom error messages that can be thrown during execution.

### Contract Definition: NFTMarketplace

```
contract NFTMarketplace is Context {
```

- Defines the main contract `NFTMarketplace`, inheriting from the `Context` contract provided by OpenZeppelin.

### State Variables

```
uint256 private counter;

struct Listing {
    uint256 price;
    address seller;
}
```

- `uint256 private counter;`:
    - Declares a private unsigned integer variable named `counter`.
    - This variable is used to keep track of some count, likely related to the number of listings or transactions in the marketplace.
    - The `private` keyword restricts access to this variable within the contract.
- `struct Listing {`:
    - Declares a new data structure called `Listing`.
    - This struct is used to define the structure of an NFT listing.
    - It contains two fields: `price`, which represents the price of the NFT, and `seller`, which represents the seller's address.
    - `uint256 price;`:
        - Declares a field `price` of type `uint256` within the `Listing` struct.
        - This field represents the price of the NFT being listed.
    - `address seller;`:
        - Declares a field `seller` of type `address` within the `Listing` struct.
        - This field represents the Ethereum address of the seller who listed the NFT.

### Events

```
event LogItemListed(
        address indexed seller,
        address indexed nftAddress,
        uint256 price
    );
```

`event LogItemListed(`

- Defines an event named `LogItemListed`.
- This event is emitted when an NFT is listed for sale in the marketplace.
- It has three parameters:
    - `address indexed seller`: Represents the Ethereum address of the seller who listed the NFT. The `indexed` keyword allows filtering events based on this parameter.
    - `address indexed nftAddress`: Represents the Ethereum address of the NFT being listed. The `indexed` keyword allows filtering events based on this parameter.
    - `uint256 price`: Represents the price at which the NFT is listed.

```
event LogItemCanceled(
        address indexed seller,
        address indexed nftAddress
    );
```

`event LogItemCanceled(`

- Defines an event named `LogItemCanceled`.
- This event is emitted when a listed NFT is canceled by the seller.
- It has two parameters:
    - `address indexed seller`: Represents the Ethereum address of the seller who canceled the listing. The `indexed` keyword allows filtering events based on this parameter.
    - `address indexed nftAddress`: Represents the Ethereum address of the NFT that was canceled. The `indexed` keyword allows filtering events based on this parameter.

```
event LogItemBought(
        address indexed buyer,
        address indexed nftAddress,
        uint256 price,
        uint256 fraction
    );
```

`event LogItemBought(`

- Defines an event named `LogItemBought`.
- This event is emitted when an NFT is bought from the marketplace.
- It has four parameters:
    - `address indexed buyer`: Represents the Ethereum address of the buyer who purchased the NFT. The `indexed` keyword allows filtering events based on this parameter.
    - `address indexed nftAddress`: Represents the Ethereum address of the NFT that was bought. The `indexed` keyword allows filtering events based on this parameter.
    - `uint256 price`: Represents the price at which the NFT was bought.
    - `uint256 fraction`: Represents some fraction or portion of the NFT bought. This parameter might be used if the NFT is divided into fractions or shares.

```
// State Variables
    mapping(address => Listing) private s_listings;
    mapping(address => uint256) private s_proceeds;
```

- `mapping(address => Listing) private s_listings;`:
    - Declares a private mapping named `s_listings`.
    - The key of the mapping is an Ethereum address (`address`), which likely represents the address of an NFT contract.
    - The value associated with each key is a `Listing` struct. This struct contains information about the NFT listing, such as its price and seller.
    - This mapping is used to store the listings of NFTs in the marketplace.
- `mapping(address => uint256) private s_proceeds;`:
    - Declares a private mapping named `s_proceeds`.
    - The key of the mapping is an Ethereum address (`address`), which likely represents the address of a seller.
    - The value associated with each key is a `uint256`, representing the proceeds (amount of Ether) earned by the seller.
    - This mapping is used to keep track of the proceeds earned by each seller from NFT sales in the marketplace.

```
// Function modifiers
    modifier isListed(address nftAddress) {
        Listing memory listing = s_listings[nftAddress];
        require(listing.price > 0, "Not listed");
        _;
    }
```

- `modifier isListed(address nftAddress) {`
    - This is a modifier named `isListed`.
    - It takes one parameter, `nftAddress`, which represents the address of an NFT.
    - Inside the modifier:
        - It creates a memory variable `listing` of type `Listing` and assigns it the value retrieved from the `s_listings` mapping using `nftAddress`.
        - It checks if the `price` in the `listing` is greater than 0, which indicates that the NFT is listed for sale.
        - If the condition is not met, it reverts the transaction with the error message "Not listed".
        - Otherwise, it continues with the execution of the function that uses this modifier.
    - The underscore `_;` indicates where the code of the function using this modifier will be placed.

```
    modifier notListed(address nftAddress) {
        Listing memory listing = s_listings[nftAddress];
        require(listing.price == 0, "Already listed");
        _;
    }
```

- `modifier notListed(address nftAddress) {`
    - This is a modifier named `notListed`.
    - It takes one parameter, `nftAddress`, which represents the address of an NFT.
    - Inside the modifier:
        - It creates a memory variable `listing` of type `Listing` and assigns it the value retrieved from the `s_listings` mapping using `nftAddress`.
        - It checks if the `price` in the `listing` is equal to 0, which indicates that the NFT is not listed for sale.
        - If the condition is not met, it reverts the transaction with the error message "Already listed".
        - Otherwise, it continues with the execution of the function that uses this modifier.
    - The underscore `_;` indicates where the code of the function using this modifier will be placed.

```
    modifier isOwner(address nftAddress, address spender) {
        IDN404 nft = IDN404(nftAddress);
        require(nft.balanceOf(spender) > 0, "Not owner");
        _;
    }
```

- `modifier isOwner(address nftAddress, address spender) {`
    - This is a modifier named `isOwner`.
    - It takes two parameters: `nftAddress`, which represents the address of an NFT, and `spender`, which represents the address of a potential owner.
    - Inside the modifier:
        - It creates a local variable `nft` of type `IDN404` and assigns it the value retrieved from the `IDN404` contract deployed at `nftAddress`.
        - It checks if the `balanceOf` the `spender` address in the `nft` contract is greater than 0, which indicates that the `spender` is the owner of the NFT.
        - If the condition is not met, it reverts the transaction with the error message "Not owner".
        - Otherwise, it continues with the execution of the function that uses this modifier.
    - The underscore `_;` indicates where the code of the function using this modifier will be placed.
    
    ## Wrap up
    
    In summary, in this lesson, we created an Ethereum-based NFT marketplace smart contract, `NFTMarketplace.sol`. It explains the use of key constructs in Solidity, including state variables, events, and function modifiers. The contract enables listing and canceling NFTs for sale and tracks sellers' proceeds.
    
    The code is not done yet, we will be completing it in the upcoming lesson. Stay tuned.