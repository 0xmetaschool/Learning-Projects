# Deploying the AirDropV2 Module

In last lesson, you created the `AirDropV2` contract. From this lesson, we will build different migrations for the `AirDropV2` contract and deploy them one by one to integrate the `AirDropV2` module with the DAO in small steps rather than all at once.

## What exactly will this script do?

1. The script is intended to be executed as part of the deployment process for the `AirDropV2` smart contract.
2. Its main purpose is to deploy the `AirDropV2` module, so we can use the address of the deployed contract later in the course.

## Let’s start off with the code

Navigate to `scripts/AirDropV2/1_deploy_airdropV2.js` and start writing the code.

Here is the code breakdown for you.

### Import libraries

In this line, we are importing the `ethers` library from the `hardhat` package. 

```
// Importing the necessary libraries
const { ethers } = require("hardhat");
```

The `ethers` library provides us with tools to interact with EVM blockchains, like Ethereum and Q, and smart contracts on these chains. 

### Main function

We will add the async `main` function, which serves as the entry point for deploying the Airdrop module.

```
async function main() {
  console.log("Deploying AirDrop V2");
  // Rest of the code will go here.
}

main();
```

Now, we will add code to our `main` function.

### Print message

First, we print a message to the console just to keep track of the flow of the code.

```
console.log("Deploying AirDrop V2");
```

### Constant variables

Now, we will fetch the contract factory of the Airdrop contract using `ethers.getContractFactory("AirDropV2")`. Think of it as a blueprint of the smart contract.

```
const AirDropV2 = await ethers.getContractFactory("AirDropV2");
```

Now, its time to deploy, again we use the contract factory to deploy the contract using  `AirDropV2.deploy()` and this will return the instance of the deployed contract which we can eventually use to interact with the contract.

```

const airdropV2 = await AirDropV2.deploy(); 
```

But before we move on we need to wait until the contract is successfully deployed on the Q blockchain using the line `await airdropV2.waitForDeployment()`

```
await airdropV2.waitForDeployment();
```

### Get address

Finally, we will get the address of the deployed `AirDropV2` contract using `airdropV2.getAddress()` and again print its address on the console. Make sure you note this address since we need this in the upcoming lessons.

```
const airdropAddress = await airdropV2.getAddress();
console.log("AirDrop V2 deployed to:", airdropAddress);
```

## Complete code

Now, let’s look at how the complete code looks like.

```
// Importing the necessary libraries
const { ethers } = require("hardhat");

// The main function for deploying the Airdrop module
async function main() {
  // Display a message to indicate the start of the deployment
  console.log("Deploying AirDrop V2");

  // Deploying AirDrop V2 contract
  const AirDropV2 = await ethers.getContractFactory("AirDropV2"); // Get the contract factory
  const airdropV2 = await AirDropV2.deploy(); // Deploy the AirdropV2 contract

  // Waiting for deployment confirmation
  await airdropV2.waitForDeployment();

  // Getting the deployed AirdropV2 contract address
  const airdropAddress = await airdropV2.getAddress();

  // Log the contract address to the console
  console.log("AirDrop V2 deployed to:", airdropAddress);
}

// Call the main function to deploy the Airdrop module
main();
```

## Let’s run the script

Follow the following steps to run the `1_deploy_airdropV2.js` file.

1. Add the DAO registry address to the `.env` file if you haven’t done it so far. 

```
DAO_REGISTRY_ADDRESS = "<YOUR-DAO-REGISTRY-ADDRESS>"
```

The DAO Registry Address is the hash you got in the DAO Factory when you deployed your DAO. It’s also shown in the URL of your DAO Dashboard (`https://hq.q-dao.tools/<YOUR-DAO-REGISTRY-ADDRESS>`), or you can find it in the Dashboard under “Parameters” in the top right corner as “DAO_REGISTRY.”

1. Remember to add the QRC20 token address to `.env` file if you still haven’t. Remember, it’s the one you got in the console when you deployed your Token, but you can also find it in your DAO Dashboard at the bottom of the “DAO Token Supply” panel.

```
QRC20_TOKEN = "YOUR-TOKEN-ADDRESS"
```

1. Finally, run the following command in your root directory (`Q-boilerplate-code`).

```
npx hardhat run scripts/AirDropV2/1_deploy_airdropV2.js --network testnet
```

1. After running the deployment file, you will get the AirDrop address on your console. Add it to your `.env` file.

```
MODULE_IMPLEMENTATION = "YOUR-AIRDROP-V2-ADDRESS"
```

Here’s how the command output will look like.

![Frame 3560339 (5).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/4.%20Adding%20the%20AirDrop%20Module%20as%20DAO%20Resource/2.%20Deploying%20the%20AirDropV2%20Module/Frame%203560339%20(5).webp)

## That’s a wrap

Congratulations on deploying the `AirDropV2` contract. Next, we will move forward and work on creating a second script for our `AirDropV2` module which will create the proposal for DAO members to vote on. The proposal will be adding the module to the registry.