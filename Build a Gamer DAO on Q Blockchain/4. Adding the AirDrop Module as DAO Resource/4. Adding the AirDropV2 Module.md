# Adding the AirDropV2 Module

In last lesson, you created the second script for adding the `AirDropV2` module. In this lesson, we will code the third script for adding the `AirDropV2` module to the DAO registry.

## What exactly this script will do?

- This script will be responsible for creating a voting proposal to add our AirDropV2 module to the DAO Registry using the GeneralDAOVoting contract and the “DAO Registry Voting Situation” we created with the last script.
- The code will utilize the DAORegistry contract and the TransparentUpgradeableProxy contract as proxy and AirDropV2 as implementation contract. contract. This setup allows a fully DAO-managed upgradability for the added module.

## Let’s start off with the code

Navigate to `scripts/AirDropV2/3_addModule.js`. Here, we will code the third script.

### Import dependencies

The code begins by importing the necessary dependencies.

```
// Importing dependencies
const { getEncodedData } = require("@q-dev/gdk-sdk");
const { ethers } = require("hardhat");
require('dotenv').config();
```

- `getEncodedData` is imported from the `@q-dev/gdk-sdk` package. It will be used to create encoded call data for contract interactions.
- `ethers` is imported from `hardhat`. It will be used to interact with EVM blockchains like Ethereum or Q.
- `dotenv` is imported to read environment variables from the `.env` file.

### Retrieve environment variables

The code retrieves `MODULE_IMPLEMENTATION`, `MODULE_NAME`, and `MAIN_DAO_VOTING_ADDRESS` from `process.env`.

```
// Retrieving environment variables
const { MODULE_IMPLEMENTATION, MODULE_NAME, MAIN_DAO_VOTING_ADDRESS } = process.env;
```

### Main function

This block defines the async main function called `main()`.

```
// The main function for deploying the voting proposal
async function main() {

//rest of the code goes here

}

main();
```

### Retrieve Ethereum accounts

The code retrieves Ethereum accounts which will be used to send the transaction using `ethers.getSigners()`. Then store the 1st account from the array of account retrieved as `senderAddress`.

```
	// Retrieving Ethereum accounts
  const accounts = await ethers.getSigners();
  const senderAddress = accounts[0].address;
```

### Constant variables

The code obtains the contract factory for the `GeneralDAOVoting` contract using `ethers.getContractFactory()`.

```
// Get the contract factories for GeneralDAOVoting
  const GeneralDAOVotingFactory = await ethers.getContractFactory("GeneralDAOVoting");
```

The obtained contract factory is then attached to the Main DAO address to create an instance and interact with our DAO using `**<contract factory>.attach(<contract address>)`.**

```
// Attach to existing instances of GeneralDAOVoting
  const VotingContract = GeneralDAOVotingFactory.attach(MAIN_DAO_VOTING_ADDRESS);
```

### Creates encoded call data

The code creates encoded call data to add the new module to the DAO Registry using the `getEncodedData()` function.

```
const addModuleCalldata = getEncodedData("DAORegistry", "addProxyContract", MODULE_NAME, MODULE_IMPLEMENTATION);
```

`getEncodedData` encodes: 

- the contract name (`DAORegistry`)
- the function name (`addProxyContract`)
- two arguments for the function (`MODULE_NAME` and `MODULE_IMPLEMENTATION`).

The encoded call data is stored in the `addModuleCalldata` variable.

### Create proposal

The code creates a voting proposal to add the new module to the DAO Registry using the `VotingContract.createProposal()` function.

```
	console.log(`Create Proposal to add ${MODULE_NAME} module to the DAO Registry`);
  await VotingContract.createProposal("DAORegistry", `Adding ${MODULE_NAME} to the DAO Contract Registry`, addModuleCalldata, {
    from: senderAddress,
  });

  console.log("Proposal Created");
```

- The proposal includes the encoded call data (`addModuleCalldata`) created earlier, which will execute the `addProxyContract` function with the provided arguments.
- The proposal is linked to the `DAORegistry` and includes a description (`Adding ${MODULE_NAME} to the DAO Contract Registry`) to provide context for voters.
- The proposal is created from the sender's address (`senderAddress`) to identify the proposer. Note: only DAO token holders can create or vote on a proposal.
- At last, a message is printed to the console indicating the creation of the proposal.

## Complete code

Now, let’s look at how the complete code looks like.

```
// Importing dependencies
const { getEncodedData } = require("@q-dev/gdk-sdk");
const { ethers } = require("hardhat");
require('dotenv').config();

// Retrieving environment variables
const { MODULE_IMPLEMENTATION, MODULE_NAME, MAIN_DAO_VOTING_ADDRESS } = process.env;

// The main function for deploying the voting proposal
async function main() {
  // Retrieving Ethereum accounts
  const accounts = await ethers.getSigners();
  const senderAddress = accounts[0].address;

  // Get the contract factories for GeneralDAOVoting
  const GeneralDAOVotingFactory = await ethers.getContractFactory("GeneralDAOVoting");

  // Attach to existing instances of GeneralDAOVoting
  const VotingContract = GeneralDAOVotingFactory.attach(MAIN_DAO_VOTING_ADDRESS);

  // Creating encoded calldata to add the new module to the DAO Registry
  const addModuleCalldata = getEncodedData("DAORegistry", "addProxyContract", MODULE_NAME, MODULE_IMPLEMENTATION);

  // Creating a voting proposal to add the module to the DAO Registry
  console.log(`Create Proposal to add ${MODULE_NAME} module to the DAO Registry`);
  await VotingContract.createProposal("DAORegistry", `Adding ${MODULE_NAME} to the DAO Contract Registry`, addModuleCalldata, {        
    from: senderAddress,
  });

  console.log("Proposal Created");
}

// Call the main function to deploy the voting proposal
main();
```

## Let’s run the script

Follow the following steps to run the `3_addModule.js` file.

1. Run the following command in your root directory, to run the migration file.

```
npx hardhat run scripts/AirDropV2/3_addModule.js --network testnet
```

Here’s how the command output will look like.

![airdrop-v2-output-2.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/4.%20Adding%20the%20AirDrop%20Module%20as%20DAO%20Resource/4.%20Adding%20the%20AirDropV2%20Module/airdrop-v2-output-2.webp)

1. Go to the DAO dashboard and move to the “Governance” section from the side bar. Here, you will find one new pending proposals.
2. Go to the proposal and vote for “yes.”

Here’s a GIF where we’re showing you to the steps for your ease.

![execute-proposal-2-dao.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_q/q-update/4.%20Adding%20the%20AirDrop%20Module%20as%20DAO%20Resource/4.%20Adding%20the%20AirDropV2%20Module/execute-proposal-2-dao.gif?raw=true)

1. Wait until the proposals passes and then go to the proposal and “Execute” it. Here’s how you can do that.

![execute-proposal-2-dao.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_q/q-update/4.%20Adding%20the%20AirDrop%20Module%20as%20DAO%20Resource/4.%20Adding%20the%20AirDropV2%20Module/execute-proposal-2-dao%20(1).gif?raw=true)

1. Once executed, you have successfully added the external module as a DAO resource.

## That’s a wrap

In summary, this deployment script set up a voting proposal within your DAO to add a new module to the DAO Registry. It utilizes environment variables to configure the proposal and interacts with the `GeneralDAOVoting` contract using the provided contract addresses and encoded `calldata`. The deployment allows the DAO members to vote on the proposal and decide whether to include the new module in the DAO's contract registry in a transparent and efficient manner.

Next, we will move forward and work on creating the fourth migration file for our `AirDropV2` module to initialize it and start using the module.