# Build the Token - I

Welcome back, folks! Great work on setting up your hardhat project. In this lesson, we will create the token using the DN404 token standard. This token will play the part of a fraction of an NFT. We will use this token to build our marketplace. Where we can buy or sell the token. A person who will have all token fractions of one NFT will own the complete NFT.

## Create Token.sol

First of all, head back to your `erc404-nftmarketplace-boilerplate` hardhat project. Navigate to the `contracts/Token.sol` file. We will add the token code in this file. If it is not created, create one like this:


![file-struct-1.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_erc404/3%20Build%20the%20MarketPlace/1%20Build%20the%20Token%20-%20I/file-struct-1.webp?raw=true)

## Start Coding

Let’s start coding and create our own DN404 token.

### Import dependencies

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Importing DN404 token contract
import "./lib/DN404.sol";
// Importing DN404Mirror contract from external source
import "dn404/src/DN404Mirror.sol";
// Importing Ownable contract from solady library
import {Ownable} from "solady/src/auth/Ownable.sol";
// Importing LibString contract from solady library
import {LibString} from "solady/src/utils/LibString.sol";
// Importing SafeTransferLib contract from solady library
import {SafeTransferLib} from "solady/src/utils/SafeTransferLib.sol";
// Importing MerkleProofLib contract from solady library
import {MerkleProofLib} from "solady/src/utils/MerkleProofLib.sol";
```

- The code begins with SPDX-License-Identifier specifying the license for the solidity code.
- It declares the solidity version that the code is compatible with.
- It imports various contracts and libraries needed for the functionality of the marketplace contract.

### Initialize the `NFTMintDN404` contract

```
contract NFTMintDN404 is DN404, ERC20Permit, Ownable{
	// Rest of the code goes here
}
```

This line defines a contract named `NFTMintDN404`, inheriting from `DN404`, `ERC20Permit`, and `Ownable` contracts. The rest of the contract code will go inside this contract.

### Declaring variables

```
    string private _name;
    string private _symbol;
    string private _baseURI;
    bytes32 private allowlistRoot;
    uint120 public publicPrice;
    uint120 public allowlistPrice;
    bool public live;
    uint256 public numMinted;
    uint256 public MAX_SUPPLY;
```

- First, we declare private variables named `_name`, `_symbol`, `_baseURI`, and `allowlistRoot`.
- Then, we declare the public variables `publicPrice`, `allowlistPrice`, `live`, `numMinted`, and `MAX_SUPPLY`.

### Custom error definition

```
    error InvalidProof();
    error InvalidPrice();
    error ExceedsMaxMint();
    error TotalSupplyReached();
    error NotLive();
```

- Here, we define multiple custom errors to use in the contract.
- These errors will help print the error message and use fewer gas fees.
- Using string statements is quite costly.
- Custom errors are used the same as events.
- Error is always used with the `revert` statement, where `revert` calls the `error` and passes any argument if there is any.

### Defining the `modifier`

```
    modifier isValidMint(uint256 price, uint256 amount) {
        if (!live) {
            revert NotLive();
        }
        if (price * amount != msg.value) {
            revert InvalidPrice();
        }
        if (numMinted + amount > MAX_SUPPLY) {
            revert TotalSupplyReached();
        }
        _;
    }
```

- Here, we define a `modifier` named `isValidMint` to check if minting is valid.
- The `modifier` allows you to modify an existing function without re-writing the entire function. It helps add functionalities to the function as we have done in our code.
- This modifier ensures that minting can only occur under certain conditions: when the contract is live, when the correct price is paid, and when the total supply limit is not exceeded. If any of these conditions are not met, the transaction is reverted with an appropriate error message.

Let’s understand what is happening inside of the function line-by-line.

```
modifier isValidMint(uint256 price, uint256 amount) {
```

- This `modifier` takes two parameters: `price` and `amount`, representing the price per token and the number of tokens to be minted, respectively.

```
    if (!live) {
        revert NotLive();
    }
```

- Here, we are checking if the contract is live.
- If the contract is not live, it reverts the transaction with the custom error `NotLive`.

```
    if (price * amount != msg.value) {
        revert InvalidPrice();
    }
```

- These lines of code check if the value sent matches the calculated price.
- If the value sent does not match the calculated price, it reverts the transaction with the custom error `InvalidPrice`.

```
    if (numMinted + amount > MAX_SUPPLY) {
        revert TotalSupplyReached();
    }
```

- These lines of code check if minting would exceed the maximum supply.
- If minting exceeds the maximum supply, it reverts the transaction with the custom error `TotalSupplyReached`.

```
    _;
```

- If all the conditions are met, it executes the function or code block that the modifier is applied to.

### Constructor function

```
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 _MAX_SUPPLY,
        uint120 publicPrice_,
        uint96 initialTokenSupply,
        address initialSupplyOwner
    ) ERC20Permit("NFTMintDN404") {
        _initializeOwner(msg.sender);

        _name = name_;
        _symbol = symbol_;
        MAX_SUPPLY = _MAX_SUPPLY;
        publicPrice = publicPrice_;

        address mirror = address(new DN404Mirror(msg.sender));
        _initializeDN404(initialTokenSupply, initialSupplyOwner, mirror);
    }
```

Here, we are defining the constructor function for our `NFTMintDN404` contract. This constructor sets up the initial configuration of the contract, including setting the owner, defining the token's name, symbol, maximum supply, and public price, and initializing the DN404 token contract.

Let’s break down this code and understand it better.

```
constructor(
    string memory name_,
    string memory symbol_,
    uint256 _MAX_SUPPLY,
    uint120 publicPrice_,
    uint96 initialTokenSupply,
    address initialSupplyOwner
) ERC20Permit("NFTMintDN404") {
```

- The constructor function takes several parameters: `name_`, `symbol_`, `_MAX_SUPPLY`, `publicPrice_`, `initialTokenSupply`, and `initialSupplyOwner`.
- It also calls the constructor of the `ERC20Permit` contract with the parameter `"NFTMintDN404"`.

```
    _initializeOwner(msg.sender);
```

- Inside the function, we call the `_initializeOwner` function inherited from the `Ownable` contract, setting the contract deployer as the owner.

```
    _name = name_;
    _symbol = symbol_;
    MAX_SUPPLY = _MAX_SUPPLY;
    publicPrice = publicPrice_;
```

- These lines of code assign values to the contract's name, symbol, maximum supply, and public price variables based on the input parameters provided during deployment.

```
    address mirror = address(new DN404Mirror(msg.sender));
    _initializeDN404(initialTokenSupply, initialSupplyOwner, mirror);
```

- These lines of code create a new instance of the `DN404Mirror` contract, passing the deployer's address as an argument.
- Then, it calls the `_initializeDN404` function inherited from the `DN404` contract, initializing the DN404 token with the initial token supply and the address of the mirror contract.

### Initializing the `mint` function

```
    function mint(uint256 amount) public payable isValidMint(publicPrice, amount) {
        unchecked {
            ++numMinted;
        }
        _mint(msg.sender, amount);
    }
```

Here, we are initializing the `mint` function. This function essentially allows users to mint tokens by sending the appropriate amount of ETH, and it ensures that the minting process is valid by checking against the current `publicPrice` and total supply limits. After validating, it increments the `numMinted` counter and mints the tokens for the user.

Let's break down the `mint` function code and understand it better:

```
function mint(uint256 amount) public payable isValidMint(publicPrice, amount) {
```

- The `mint` function allows users to mint tokens by providing an `amount` of tokens they want to mint.
- The `mint` function is marked as `public`, meaning it can be called externally.
- It also requires users to send ETH along with the function call, as indicated by the `payable` modifier.
- Additionally, it utilizes the `isValidMint` modifier to check if minting is valid based on the provided `publicPrice` and `amount`.

```
    unchecked {
        ++numMinted;
    }
```

- This section uses the `unchecked` keyword, indicating that the arithmetic operations within this block will not be checked for overflows.
- It increments the `numMinted` variable, representing the total number of tokens that have been minted.

```
    _mint(msg.sender, amount);
```

- This line calls the `_mint` function inherited from the `DN404` contract, which mints the specified `amount` of tokens for the caller (`msg.sender`).

### Initializing the `allowlistMint` function

```
    function allowlistMint(uint256 amount, bytes32[] calldata proof)
        public
        payable
        isValidMint(allowlistPrice, amount)
    {
        if (
            !MerkleProofLib.verifyCalldata(
                proof, allowlistRoot, keccak256(abi.encodePacked(msg.sender))
            )
        ) {
            revert InvalidProof();
        }
        unchecked {
            ++numMinted;
        }
        _mint(msg.sender, amount);
    }
```

The `allowlistMint` function allows users on the allowlist to mint tokens by providing proof of eligibility and the desired amount of tokens. It verifies the proof against the allowlist, increments the `numMinted` counter, and mints the tokens for the user if they are eligible. If the proof is invalid, the transaction is reverted with an error message. 

Let's break down the `allowlistMint` function and understand the code line-by-line:

```
function allowlistMint(uint256 amount, bytes32[] calldata proof)
    public
    payable
    isValidMint(allowlistPrice, amount)
{
```

- The `allowlistMint` function allows users on an allowlist to mint tokens by providing an `amount` of tokens they want to mint and a proof of eligibility.
- It's marked as `public`, meaning it can be called externally.
- It also requires users to send ETH along with the function call, as indicated by the `payable` modifier.
- Additionally, it utilizes the `isValidMint` modifier to check if minting is valid based on the provided `allowlistPrice` and `amount`.

```
if (
    !MerkleProofLib.verifyCalldata(
        proof, allowlistRoot, keccak256(abi.encodePacked(msg.sender))
    )
) {
    revert InvalidProof();
}
```

- This block of code checks whether the caller (`msg.sender`) is included in the allowlist by verifying the provided `proof` using the `MerkleProofLib.verifyCalldata` function.
- If the caller is not on the allowlist, it reverts the transaction with the custom error `InvalidProof`.

```
unchecked {
    ++numMinted;
}
```

- This section uses the `unchecked` keyword, indicating that the arithmetic operations within this block will not be checked for overflows.
- It increments the `numMinted` variable, representing the total number of tokens that have been minted.

```
_mint(msg.sender, amount);
```

- This line calls the `_mint` function inherited from the `DN404` contract, which mints the specified `amount` of tokens for the caller (`msg.sender`).

## That’s a wrap

In this lesson, we have completed half of our `NFTMintDN404` contract code. We have added all the main functionalities like defining the constructor function, minting the token, validating the mint process, and allowing the token holders to mint their share of tokens. Next, we will add more functionalities to our `NFTMintDN404` contract. So, stay tuned!