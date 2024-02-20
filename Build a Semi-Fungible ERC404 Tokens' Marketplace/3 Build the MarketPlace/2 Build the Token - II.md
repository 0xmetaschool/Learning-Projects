# Build the Token - II

Lastly, you built half of the DN404 token. In this lesson, we will get back to building our DN404 token. Without any delay let's dive in!

## Continue coding

Let’s complete the `NFTMintDN404` contract code.

### Initializing the `setBaseURI` function

```
    function setBaseURI(string calldata baseURI_) public onlyOwner {
        _baseURI = baseURI_;
    }
```

The `setBaseURI` function provides a convenient way for the contract owner to update the base URI for token metadata, which is often used to retrieve additional information about tokens, such as their images or descriptions. By calling this function, the owner can easily customize the metadata URLs without needing to deploy a new contract.

Technically:

- The `calldata` keyword in the input field specifies that the `baseURI_` parameter will be provided as input data to the function.
- `_baseURI` is a private variable that holds the base URI for token metadata.

### Initializing the `setPrices` function

```
    function setPrices(uint120 publicPrice_, uint120 allowlistPrice_) public onlyOwner {
        publicPrice = publicPrice_;
        allowlistPrice = allowlistPrice_;
    }
```

By calling this function, the contract owner can easily adjust the prices for minting tokens without needing to redeploy the contract. This provides flexibility in managing the cost of minting tokens based on market conditions or other factors.

Technically:

- The `setPrices` function allows the contract owner to set the public and allowlist prices for minting tokens. It's marked as `public`, meaning it can be called externally.
- The `onlyOwner` modifier ensures that only the owner of the contract can execute this function.
- Inside of the function, we update the `publicPrice` and `allowlistPrice` variables with the values provided as parameters (`publicPrice_` and `allowlistPrice_`, respectively).
- `publicPrice` represents the price per token for public minting, while `allowlistPrice` represents the price per token for users on the allowlist.

### Initializing the `toggleLive` function

```
    function toggleLive() public onlyOwner {
        live = !live;
    }
```

The `toggleLive` function provides a straightforward way for the contract owner to manage the overall functionality of the contract by enabling or disabling specific features as needed. It offers flexibility and control over the contract's behavior.

Technically:

- The `onlyOwner` modifier ensures that only the owner of the contract can execute this function.
- The `live = !live;` line of code toggles the value of the `live` variable.
- If `live` is currently `true`, it sets it to `false`, and vice versa.
- The `live` variable typically controls whether certain functionalities of the contract are active or not. Toggling it allows the owner to enable or disable specific features of the contract.

### Initializing the `withdraw` function

```
    function withdraw() public onlyOwner {
        SafeTransferLib.safeTransferAllETH(msg.sender);
    }
```

The `withdraw` function provides a secure way for the contract owner to withdraw any accumulated ETH from the contract. By calling this function, the owner can retrieve funds from the contract balance whenever necessary, ensuring control over the contract's financial resources.

Technically, the line `SafeTransferLib.safeTransferAllETH(msg.sender);` works like this:

- This line of code calls the `safeTransferAllETH` function from the `SafeTransferLib` contract.
- The `safeTransferAllETH` function transfers all ETH balances from the contract to the address specified as an argument.
- In this case, `msg.sender` represents the owner of the contract, so all ETH will be transferred to the owner's address.

### Retrieving the basic information

```
    function name() public view override returns (string memory) {
        return _name;
    }

    function symbol() public view override returns (string memory) {
        return _symbol;
    }
```

These functions provide a way for external parties to retrieve basic information about the token, such as its name and symbol. By calling these functions, users or other contracts can obtain essential details about the token without needing access to the contract's internal state variables.

Technically:

- The functions are marked as `public`, meaning they can be called externally.
- The `view` modifier indicates that the functions will not modify the contract's state.
- The `override` keyword indicates that the functions override a function from a parent contract.

### Initializing the `tokenURI` function

```
    function tokenURI(uint256 tokenId) public view override returns (string memory result) {
        if (bytes(_baseURI).length != 0) {
            result = string(abi.encodePacked(_baseURI, LibString.toString(tokenId)));
        }
    }
```

Here, we are initializing the `tokenURI` function. If there's no base URI set, the function returns an empty string. Otherwise, it constructs the full URI for the token metadata by combining the base URI with the token ID. This function is essential for retrieving metadata associated with a specific token, such as its image, description, or attributes.

Let’s understand the code in detail.

- `if (bytes(_baseURI).length != 0) {}`
    - This line checks if the `_baseURI` variable is not empty.
    - If the `_baseURI` is not empty, it means there's a base URI set for token metadata.
- `result = string(abi.encodePacked(_baseURI, LibString.toString(tokenId)));`
    - This line of code constructs the token URI by concatenating the base URI with the string representation of the **`tokenId`**.
    - The **`abi.encodePacked`** function is used to efficiently concatenate the base URI and token ID as a single string.
    - The resulting URI is assigned to the **`result`** variable.

### Initializing the allowlist management functions

```
    function setAllowlist(bytes32 allowlistRoot_) public onlyOwner {
        allowlistRoot = allowlistRoot_;
    }

    function setAllowlistPrice(uint120 allowlistPrice_) public onlyOwner {
        allowlistPrice = allowlistPrice_;
    }

```

These functions provide a straightforward way for the contract owner to manage the allowlist functionality by setting the allowlist root hash and adjusting the price per token for allowlist minting. By calling these functions, the owner can control who is allowed to mint tokens and at what price, ensuring flexibility and customization of the minting process.

### Initializing the utility functions

```
    function nftTotalSupply() public view returns (uint256) {
        return _totalNFTSupply();
    }

    function nftbalanceOf(address owner) public view returns (uint256) {
        return _balanceOfNFT(owner);
    }

    function previewNextTokenId() public view returns (uint256) {
        return _nextTokenId();
    }

    function getURI() public view returns(string memory) {
        return _baseURI;
    }

```

These functions provide useful information and utilities related to the NFTs minted by the contract, such as the total supply, the balance of NFTs owned by a specific address, the ID of the next token to be minted, and the base URI for token metadata. They enable users or other contracts to retrieve essential details about the NFTs managed by the contract.

## Complete code

Here’s the complete code for the `NFTMintDN404` contract that goes in `Token.sol` file.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./lib/DN404.sol";
import "dn404/src/DN404Mirror.sol";
import {Ownable} from "solady/src/auth/Ownable.sol";
import {LibString} from "solady/src/utils/LibString.sol";
import {SafeTransferLib} from "solady/src/utils/SafeTransferLib.sol";
import {MerkleProofLib} from "solady/src/utils/MerkleProofLib.sol";

contract NFTMintDN404 is DN404, ERC20Permit, Ownable{
    string private _name;
    string private _symbol;
    string private _baseURI;
    bytes32 private allowlistRoot;
    uint120 public publicPrice;
    uint120 public allowlistPrice;
    bool public live;
    uint256 public numMinted;
    uint256 public MAX_SUPPLY;

    error InvalidProof();
    error InvalidPrice();
    error ExceedsMaxMint();
    error TotalSupplyReached();
    error NotLive();

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

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 _MAX_SUPPLY,
        uint120 publicPrice_,
        uint96 initialTokenSupply,
        address initialSupplyOwner
    ) ERC20Permit("ERC404Token") {
        _initializeOwner(msg.sender);

        _name = name_;
        _symbol = symbol_;
        MAX_SUPPLY = _MAX_SUPPLY;
        publicPrice = publicPrice_;

        address mirror = address(new DN404Mirror(msg.sender));
        _initializeDN404(initialTokenSupply, initialSupplyOwner, mirror);
    }

    function mint(uint256 amount) public payable isValidMint(publicPrice, amount) {
        unchecked {
            ++numMinted;
        }
        _mint(msg.sender, amount);
    }

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

    function setBaseURI(string calldata baseURI_) public onlyOwner {
        _baseURI = baseURI_;
    }

    function setPrices(uint120 publicPrice_, uint120 allowlistPrice_) public onlyOwner {
        publicPrice = publicPrice_;
        allowlistPrice = allowlistPrice_;
    }

    function toggleLive() public onlyOwner {
        if (live)
        {
           live = false;
        } else {
           live = true;
        }
    }

    function withdraw() public onlyOwner {
        SafeTransferLib.safeTransferAllETH(msg.sender);
    }

    function name() public view override returns (string memory) {
        return _name;
    }

    function symbol() public view override returns (string memory) {
        return _symbol;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory result) {
        if (bytes(_baseURI).length != 0) {
            result = string(abi.encodePacked(_baseURI, LibString.toString(tokenId)));
        }
    }

    function setAllowlist(bytes32 allowlistRoot_) public onlyOwner {
        allowlistRoot = allowlistRoot_;
    }

    function setAllowlistPrice(uint120 allowlistPrice_) public onlyOwner {
        allowlistPrice = allowlistPrice_;
    }

    function nftTotalSupply() public view returns (uint256) {
        return _totalNFTSupply();
    }

    function nftbalanceOf(address owner) public view returns (uint256) {
        return _balanceOfNFT(owner);
    }

    function previewNextTokenId() public view returns (uint256) {
        return _nextTokenId(); 
    }

    function getURI() public view returns(string memory) {
        return _baseURI;
    }

}
```

## That’s a wrap

Congratulations! You have implemented the DN404 token from start to end! You are surely a nerd. And we’re so proud of you for this. Next, we will build the marketplace contract. This marketplace contract will help us list our tokens on the marketplace and buy or sell the tokens with ease. So, what are you waiting for? Let’s dive in!