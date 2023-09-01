# Create and Deploy QRC20 Token

Hi, welcome back! So you have set up your Hardhat project. Now it’s time to create a QRC20 Token so we can use it later when we create our DAO.

## Let’s start coding

Navigate to `contracts/QRC20.sol`. This code is a part of Q GDK contracts so you don't have to write it and we’ll explain the code. So let’s start understanding the code of the contract QRC20 token with features of minting, burning, total supply cap, and contract metadata.

```
// SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity 0.8.19;

```

- The above lines specify the license for the contract (LGPL-3.0-or-later) and the version of the Solidity compiler to use (0.8.19).

```
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
```

- These lines import two modules from the OpenZeppelin library: `OwnableUpgradeable` and `ERC20Upgradeable`.
- The `OwnableUpgradeable` contract provides a basic implementation of an ownership mechanism to restrict access to certain functions to only the contract owner.
- The `ERC20Upgradeable` contract provides an implementation of the ERC-20 token standard with upgradability features.

```
import "@q-dev/gdk-contracts/interfaces/tokens/IQRC20.sol";
import "@q-dev/gdk-contracts/metadata/ContractMetadata.sol";
```

- These lines import two modules: `IQRC20` and `ContractMetadata` from the `@q-dev/gdk-contracts` library.
- `IQRC20` is an interface defining the standard functions of a QRC20 token.
- `ContractMetadata` provides functionality to add metadata to the contract, such as a contract URI.

```
contract QRC20 is IQRC20, ERC20Upgradeable, ContractMetadata, OwnableUpgradeable {
```

- This line declares the `QRC20` contract, which inherits from four other contracts: `IQRC20`, `ERC20Upgradeable`, `ContractMetadata`, and `OwnableUpgradeable`.
- The contract is a regular QRC20 token with additional features, including minting and burning tokens, a total supply cap, and contract metadata.

```
string public QRC20_RESOURCE;
uint256 public totalSupplyCap;
uint8 internal _decimals;

```

- These lines declare three state variables:
    - `QRC20_RESOURCE`: A string variable to store the resource of the QRC20 token.
    - `totalSupplyCap`: A uint256 variable to set the total supply cap of the token. It restricts the total supply of the token.
    - `_decimals`: An internal uint8 variable to store the number of decimals for the token. When you’ll mint or transfer tokens, you will be actually sending the `the_count_of_tokens * 10^decimals`.

```
function initialize(
    string calldata name_,
    string calldata symbol_,
    uint8 decimals_,
    string calldata contractURI_,
    string calldata resource_,
    uint256 totalSupplyCap_
) public initializer {
```

- The function `initialize` is a special function in the contract that is used for initializing the contract's state variables when the contract is deployed.
- The initialize function takes six input parameters:
    - `name_`: A string representing the name of the QRC20 token.
    - `symbol_`: A string representing the symbol of the QRC20 token (e.g., "BTC").
    - `decimals_`: An unsigned integer representing the number of decimals for the token (e.g., 18 for Ether).
    - `contractURI_`: A string containing the contract URI (Uniform Resource Identifier), which is used to provide metadata for the contract.
    - `resource_`: A string representing the resource of the QRC20 token.
    - `totalSupplyCap_`: An unsigned integer representing the maximum total supply cap for the token (optional; set to 0 for no cap).

```
 public initializer {
    __ERC20_init(name_, symbol_);
    __ContractMetadata_init(contractURI_);
    QRC20_RESOURCE = resource_;
    _decimals = decimals_;
    totalSupplyCap = totalSupplyCap_;

    //Set Owner
    __Ownable_init();
}
```

Let’s take a look at the code inside the `public initializer` function:

- The line `__ERC20_init(name_, symbol_);` calls the `__ERC20_init` function inherited from `ERC20Upgradeable`. This initializes the ERC20 token with the given `name_` and `symbol_`. It sets the name and symbol of the token, which are required for an ERC20 token.
- The line `__ContractMetadata_init(contractURI_);` calls the `__ContractMetadata_init` function inherited from `ContractMetadata`. This initializes the contract metadata with the provided `contractURI_`. The contract URI is used to provide additional information and metadata about the contract on-chain.
- The line `QRC20_RESOURCE = resource_;` sets the `QRC20_RESOURCE` variable to the value of `resource_`. This variable stores the resource of the QRC20 token, which could be a description or a link to external resources related to the token.
- The line `_decimals = decimals_;` sets the `_decimals` variable to the value of `decimals_`. This variable stores the number of decimals for the token, which is essential for handling fractional amounts of the token.
- The line `totalSupplyCap = totalSupplyCap_;` sets the `totalSupplyCap` variable to the value of `totalSupplyCap_`. This variable represents the maximum total supply cap for the token. If it is set to 0, there is no cap on the total supply.
- The line `__Ownable_init();` calls the `__Ownable_init` function inherited from `OwnableUpgradeable`. This initializes the contract with an owner, who has certain privileges and can perform specific actions that are restricted to the owner.

```
modifier onlyChangeMetadataPermission() override {
    _checkOwner();
    _;
}
```

This is a modifier called `onlyChangeMetadataPermission`:

- It overrides the same-named function from the `IQRC20` interface.
- The modifier checks whether the function caller is the contract owner before executing the function.

```
function mintTo(address account, uint256 amount) external override onlyOwner {
    require(totalSupplyCap == 0 || totalSupply() + amount <= totalSupplyCap, "[QGDK-015000]-The total supply capacity exceeded, minting is not allowed.");
    _mint(account, amount);
}
```

- This function `mintTo` allows the contract owner to mint new tokens to a specified account.
- The `onlyOwner` modifier ensures that only the contract owner can call this function.
- The function checks if the total supply cap is not reached before minting new tokens using the `require` statement.
- If the condition is met, the `_mint` function is called to mint the tokens.

```
function burnFrom(address account, uint256 amount) external override {
    if (account != msg.sender) {
        _spendAllowance(account, msg.sender, amount);
    }
    _burn(account, amount);
}
```

- The `burnFrom` function allows a user to burn their own tokens or tokens from another account with proper approval (allowance).
- If the caller is not the account owner (`msg.sender`), the function calls `_spendAllowance` to reduce the allowance of the account by the specified amount.
- Then, the function calls `_burn` to burn the tokens from the account.

```
function decimals() public view override returns (uint8) {
    return _decimals;
}
```

- This function `decimals` is a public view function that returns the number of decimals for the token.
- It is defined as part of the `IQRC20` interface and overrides it. The value is fetched from the `_decimals` variable.

## Complete code

The complete code of QRC20 Token is below:

```
// SPDX-License-Identifier: LGPL-3.0-or-later
pragma solidity 0.8.19;

// Import necessary contracts
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@q-dev/gdk-contracts/interfaces/tokens/IQRC20.sol";
import "@q-dev/gdk-contracts/metadata/ContractMetadata.sol";

/**
 * @title QRC20
 *
 * Regular QRC20 token with additional features:
 * - minting and burning
 * - total supply cap
 * - contract metadata
 */
contract QRC20 is IQRC20, ERC20Upgradeable, ContractMetadata, OwnableUpgradeable{
    string public QRC20_RESOURCE; // Resource of the QRC20 token
    uint256 public totalSupplyCap; // Maximum total supply cap of the token
    uint8 internal _decimals; // Number of decimals for the token

    // Initialize the contract with provided metadata and configuration
    function initialize(
        string calldata name_,
        string calldata symbol_,
        uint8 decimals_,
        string calldata contractURI_,
        string calldata resource_,
        uint256 totalSupplyCap_
    ) public initializer {
        __ERC20_init(name_, symbol_); // Initialize ERC20 token with name and symbol
        __ContractMetadata_init(contractURI_); // Initialize contract metadata with URI
        QRC20_RESOURCE = resource_; // Set QRC20 resource
        _decimals = decimals_; // Set token decimals
        totalSupplyCap = totalSupplyCap_; // Set total supply cap

        // Set contract owner
        __Ownable_init();
    }

    // Modifier to restrict functions that can change metadata only to the owner
    modifier onlyChangeMetadataPermission() override {
        _checkOwner();
        _;
    }

    // Mint new tokens to the specified account (onlyOwner)
    function mintTo(address account, uint256 amount) external override onlyOwner {
        require(totalSupplyCap == 0 || totalSupply() + amount <= totalSupplyCap, "[QGDK-015000]-The total supply capacity exceeded, minting is not allowed.");
        _mint(account, amount);
    }

    // Burn tokens from the specified account (either self or with allowance)
    function burnFrom(address account, uint256 amount) external override {
        if (account != msg.sender) {
            _spendAllowance(account, msg.sender, amount);
        }
        _burn(account, amount);
    }

    // Get the number of decimals for the token
    function decimals() public view override returns (uint8) {
        return _decimals;
    }
}
```

## Deploy the token

You will need a javascript file to deploy the token on the Q Blockchain. This will do the same as we did in the RemixIDE earlier, but this time from your own computer. Navigate to `scripts/AirDropV1/1_deploy_token.js`.

### Code for deploy script

```
const { ethers, upgrades } = require("hardhat");
Web3 = require('web3');
```

- The above lines import necessary modules for the script to work.
- `ethers` and `upgrades` are used from the `hardhat` library to interact with the Ethereum blockchain and handle contract upgrades.
- `Web3` is used to work with the Ethereum network.

```
async function main() {
```

- The script defines an asynchronous function named `main`.
- The `async` keyword indicates that the function contains asynchronous operations that will return Promises.

```
    //Metadata
    const name = "Meta DAO";
    const symbol = "Meta";
    const decimals = 18; // or any other value you want
    const contractURI = "";
    const resource = "QRC20_RESOURCE";
    const totalSupplyCap = Web3.utils.toWei('1000000000', 'ether');
```

- The above lines declare variables that store the metadata and configuration for the QRC20 token that will be deployed.
- `name`, `symbol`, and `decimals` represent the name, symbol, and number of decimals for the token.
- `contractURI` is an empty string in this example, but it can be used to store metadata about the contract, like a JSON file URI.
- `resource` is a string variable that holds the resource of the QRC20 token.
- `totalSupplyCap` is the total supply cap of the token, set to 1 billion (1,000,000,000) tokens, converted to `wei` using the `Web3.utils.toWei` function.

```
    console.log("Deploying QRC20")
    const QRC20 = await ethers.getContractFactory("QRC20");
    const qrc = await upgrades.deployProxy(QRC20, [name,symbol,decimals,contractURI,resource,totalSupplyCap], {initializer:"initialize", kind: "transparent"});
```

- The line `console.log("Deploying QRC20")` logs a message to the console, indicating that the deployment of the QRC20 token is starting.
- `ethers.getContractFactory("QRC20")` fetches the factory of the `QRC20` contract from the compiled artifacts using the `ethers` library.
- `upgrades.deployProxy(...)` deploys an upgradeable version of the QRC20 contract using the `upgrades` library.
- It takes the `QRC20` factory, along with the constructor arguments `[name, symbol, decimals, contractURI, resource, totalSupplyCap]`.
- The `{initializer:"initialize", kind: "transparent"}` object specifies that the `initialize` function is the initializer of the contract, and the contract is a transparent proxy.

```
    await qrc.waitForDeployment();
    const qrc20Address = await qrc.getAddress();
    console.log("QRC20 deployed to:", qrc20Address);
```

- `await qrc.waitForDeployment()` waits for the contract deployment to complete.
- `await qrc.getAddress()` retrieves the address of the deployed QRC20 token contract.
- The line `console.log("QRC20 deployed to:", qrc20Address);` logs the address of the deployed QRC20 token to the console.

```
main();
```

- The `main()` function is called, starting the script and deploying the QRC20 token.

### Complete code

The complete code of `1_deploy_token.js` is below:

```
// Import necessary modules
const { ethers, upgrades } = require("hardhat");
Web3 = require('web3');

// Asynchronous function to deploy QRC20 token
async function main() {
    
    // Set metadata for the QRC20 token
    const name = "Meta DAO";
    const symbol = "Meta";
    const decimals = 18; // or any other value you want
    const contractURI = "";
    const resource = "QRC20_RESOURCE";
    const totalSupplyCap = Web3.utils.toWei('1000000000', 'ether');

    // Display deployment message
    console.log("Deploying QRC20");

    // Get the QRC20 contract factory
    const QRC20 = await ethers.getContractFactory("QRC20");

    // Deploy an upgradeable QRC20 contract using the factory
    const qrc = await upgrades.deployProxy(QRC20, [name,symbol,decimals,contractURI,resource,totalSupplyCap], {initializer:"initialize", kind: "transparent"});

    // Wait for the deployment process to complete
    await qrc.waitForDeployment();

    // Get the address of the deployed QRC20 contract
    const qrc20Address = await qrc.getAddress();

    // Log the deployment address
    console.log("QRC20 deployed to:", qrc20Address);
}

// Call the main function to deploy the QRC20 token
main();
```

## Command to deploy the token

Now open your terminal from your Q-boilerplate-code directory and run the following command to finally deploy your QRC20 token:

```
npx hardhat run scripts/AirDropV1/1_deploy_token.js --network testnet
```

The output of this will be similar to below (ignore any warning encountered):

![Frame 3560365.jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Create%20and%20Deploy%20QRC20%20Token/Frame_3560365.jpg?raw=true)

It will give a contract address. ***Copy the contract address. We will use it in the next lesson for the DAO creation.***

Also, add the contract address to your `.env` file in the following format, we will use this environment variable in upcoming lessons.

```
QRC20_TOKEN = "YOUR-CONTRACT-ADDRESS"
```

- **Information about potential errors:** You may encounter any of the following common errors, let me explain how you can resolve them:

- **ProviderError**: Insufficient funds for gas * price + value ⇒ Use the Q faucet at [faucet.qtestnet.org](http://faucet.qtestnet.org) to claim tokens to the wallet/private key you use for deploying the code.

- **Error**: Factory runner does not support sending transactions ⇒ There is a typo in your private key in the `.env` file, or the `.env` file with the private key is not in the right directory (should be in the root directory `Q-boilerplate-code`.)

## That’s a wrap

In this lesson, we learned how to create and deploy a QRC20 token using Hardhat and OpenZeppelin libraries. We started by writing the code for the QRC20 contract, including features like minting, burning, and total supply cap. We then created a JavaScript file to deploy the token. Finally, we ran the deployment script using the `npx hardhat run` command.

In the next lesson, we will build a DAO using the contract address of our freshly deployed QRC20 token.
