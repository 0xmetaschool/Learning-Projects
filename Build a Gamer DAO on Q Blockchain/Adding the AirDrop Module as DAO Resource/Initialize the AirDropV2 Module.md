# Initialize the AirDropV2 Module

In last lesson, you created the third script for adding the AirDropV2 module to your DAO, were we added the module to the DAO Registry and turned into an official DAO resource. In this lesson, we will build the fourth script for initializing the AirDropV2 module and finalizing the setup.

## What exactly will this script do?

Let’s first explore what the forth migration will do.

- The main purpose of this code is to enable the seamless integration and activation of the `AirDropV2` module within your DAO.
- The `AirDropV2` module is responsible for handling airdrop functionalities, which typically involve the distribution of tokens to a specified group of addresses in a decentralized manner.

## Let’s start off with the code

Navigate to the `scripts/AirDropV2/4_initModule.js`. Here, we will code the fourth script.

### Import dependencies

First of all, we will import the dependencies.

```
const { ethers } = require("hardhat");
require('dotenv').config();

const { MODULE_NAME, DAO_REGISTRY_ADDRESS, VOTING_CONTRACT_ADDRESS } = process.env;

```

- The above lines import necessary modules for the script to work. `ethers` is used to interact with EVM Blockchains like Ethereum or Q and smart contracts using Hardhat.
- The script also uses `dotenv` to load environment variables from a `.env` file, which helps in configuring the script.
- `MODULE_NAME`, `DAO_REGISTRY_ADDRESS`, and `VOTING_CONTRACT_ADDRESS` are environment variables loaded from the `.env` file.

### Main function

This block defines the async main function called `main()`.

```
async function main() {

		// Rest of the code here

}

main();
```

From now on we will add the code to the `main` function.

### Fetch account address

Again, we will be fetching the `senderAddress` as explained in the last lesson using `ethers.getSigners()`.

```
const accounts = await ethers.getSigners();
const senderAddress = accounts[0].address;
```

### Constant variables

This block fetches the contract factories for the `DAORegistry` and `AirDropV2` contracts using `ethers.getContractFactory()`.

```
const DAORegistryFactory = await ethers.getContractFactory("DAORegistry");
const AirDropV2Factory = await ethers.getContractFactory("AirDropV2");

const daoRegistry = DAORegistryFactory.attach(DAO_REGISTRY_ADDRESS);
const AirDropProxy = AirDropV2Factory.attach(await daoRegistry.getContract(MODULE_NAME));
```

- Here, we are attaching the contract factories to the DAO registry address and the address of our AirdropV2 contract from the DAO registry respectively.
- This is again a pretty straight forward process as explained in the last lesson. Only this time, for the AirDropV2 contract address, we will use the instance of the DAO Registry to call the `getContract()` function which takes the name of the module as a parameter and returns the address of the AirDropV2 contract.

### Init `AirDropV2` module

This block initializes the `AirDropV2` module by calling its `__AirDropV2_init` function.

```
console.log(`Initialize ${MODULE_NAME}`);
await AirDropProxy.__AirDropV2_init(VOTING_CONTRACT_ADDRESS, {
    from: senderAddress,
});

console.log(`Initialized ${MODULE_NAME}`);
```

- The function takes `VOTING_CONTRACT_ADDRESS` as a parameter and we again send the transaction from the `senderAddress` (This part is optional if you don’t have multiple addresses).
- Lastly, the`console.log` statements are used to indicate the initialization process and its completion.

## Complete code

Here’s how the complete code looks like.

```
// Import necessary modules
const { ethers } = require("hardhat");
require('dotenv').config();

// Load environment variables
const { MODULE_NAME, DAO_REGISTRY_ADDRESS, VOTING_CONTRACT_ADDRESS } = process.env;

// Asynchronous function to initialize the AirDropV2 module
async function main() {

    // Get Ethereum accounts from Hardhat
    const accounts = await ethers.getSigners();
    const senderAddress = accounts[0].address;

    // Get the contract factories for DAORegistry and AirDropV2
    const DAORegistryFactory = await ethers.getContractFactory("DAORegistry");
    const AirDropV2Factory = await ethers.getContractFactory("AirDropV2");

    // Attach to existing instances of DAORegistry and AirDropV2
    const daoRegistry = DAORegistryFactory.attach(DAO_REGISTRY_ADDRESS);
    const AirDropProxy = AirDropV2Factory.attach(await daoRegistry.getContract(MODULE_NAME));

    // Initialize the AirDropV2 module
    console.log(`Initialize ${MODULE_NAME}`);
    await AirDropProxy.__AirDropV2_init(VOTING_CONTRACT_ADDRESS, {        
        from: senderAddress,
    });

    console.log(`Initialized ${MODULE_NAME}`);
}

// Call the main function to initialize the AirDropV2 module
main();
```

## Run fourth migration file

Run the following command:

```
npx hardhat run scripts/AirDropV2/4_initModule.js --network testnet
```

The command will give you the following output.

![airdrop-v2-output-3.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_q/q-update/4.%20Adding%20the%20AirDrop%20Module%20as%20DAO%20Resource/5.%20Initialize%20the%20AirDropV2%20Module/airdrop-v2-output-3.png?raw=true)

## That’s a wrap

In summary, this script initializes the `AirDropV2` module by calling its `__AirDropV2_init` function with the specified parameters. The script uses the provided environment variables to fetch contract addresses, and the `ethers` library to interact with the Q blockchain. It demonstrates how to connect to existing contract instances and initialize a contract module within a DAO system.

Congratulations you have successfully added a Airdrop module as a DAO resource, now you will be able to create and manage the Airdrop campaign from the DAO itself, so let’s not waste time and move on to create a frontend to interact with the new functions we have added to our DAO.