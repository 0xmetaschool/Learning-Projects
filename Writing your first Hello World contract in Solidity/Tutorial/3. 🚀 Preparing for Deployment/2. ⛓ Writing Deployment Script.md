# 🚀 Preparing for Deployment

## **⛓ Writing Deployment Script**

Now is the time to write the deployment script. Now, we will create a deploy.js file in the scripts folder and this file will contain all the logic for deployment. Before that we run the following command in the terminal.

```
npm install --save-dev @nomiclabs/hardhat-ethers
```

Hardhat ethers is a plugin that gives us access to ethers.js library. Ethers.js library gives us a way to interact with the blockchain world, we can deploy contracts, we can fetch contracts, we can call their functions, all thanks to this library.

Your deploy.js file will look like this.

```
const { ethers } = require("hardhat");
async function main() {
 
   const HelloWorld = await ethers.getContractFactory('HelloWorld');
 
   const hw = await HelloWorld.deploy("Hello World! Bingo");
 
   console.log('Contract Deployed to:', hw.address);
}
 
main().then(() => process.exit(0))
.catch(error => {
 console.error(error);
 process.exit(1);
});
```

Booooooommmmmmmm!!! 🚀🚀🚀🚀 We are ready for deployment. Run the following command.

```
npx hardhat run scripts/deploy.js --network rinkeby
```

If all goes well, your contract will be deployed and you will be able to see the address of the contract on the terminal. Copy that and save in your .env file, we will use it later to interact with the contract.

Congratulations!! Congratulations!! Congratulations!!  
  
Your contract is deployed. ⛺️🚀⛺️🚀⛺️

A cool thing you can do right now is go to  [rinkeby.etherscan.io](https://rinkeby.etherscan.io/)  and copy paste your contract and read more about it.  
  
🔥🔥🔥🔥 Etherscan is  **a tool to help you view data regarding any pending or confirmed Ethereum blockchain transactions**. Since Ethereum is a public, open blockchain, whenever anyone interacts with it the action is recorded into the transaction history and it is open for anyone to see.

### Assignment

#### ⛺️ Coding Camp Progress

Share your contract address.

**Your response is**
