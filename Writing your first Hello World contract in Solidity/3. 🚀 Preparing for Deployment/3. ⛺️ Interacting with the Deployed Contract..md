# 🚀 Preparing for Deployment

## **⛺️ Interacting with the Deployed Contract.**

In the same scripts folder, create a new file interact.js. And add the following code.

```
const { ethers } = require("hardhat");
 
const API_KEY = process.env.API_KEY; //get from alchemy
const CONTRACT_ADDRESS = process.env.CONTRACT; //deployed contract address
const PRIVATE_KEY = process.env.PRIVATE_KEY; //metamask
 
const contract = require('../artifacts/contracts/HelloWorld.sol/HelloWorld.json');
 
// provider - Alchemy
const alchemyProvider = new ethers.providers.AlchemyProvider(network="rinkeby", API_KEY);
 
// signer - you
const signer = new ethers.Wallet(PRIVATE_KEY, alchemyProvider);
 
// contract instance
const helloWorldContract = new ethers.Contract(CONTRACT_ADDRESS, contract.abi, signer);
 
async function main() {
 
    const message = await helloWorldContract.message();
    console.log("the message is "+ message);
 
    const tx = await helloWorldContract.update("Good Bye, World!");
    await tx.wait();
 
    const nmessage = await helloWorldContract.message();
    console.log("the new message is "+ nmessage);
}
 
main()
.then(() => process.exit(0))
.catch(error => {
  console.error(error);
  process.exit(1);
});
```

Ether.js library gives us providers, which are basically the interface for our interaction with the Ethereum Blockchain nodes. When a request is made, it is sent to multiple backends simultaneously. As responses from each backend are returned, they are checked that they agree. Once a quorum has been reached (i.e. enough of the backends agree), the response is provided to your application.

Signers is an abstraction of an ethereum account. The signers can be used to sign messages and transactions which can result in calling function, changing state variables etc. Here we are sharing our account private key, because we are the signers of this transaction.

Rest of the code is very much the same, we fetch the current value of the message and then replace it with the new one. Run the following command again but this time, we will call the interact.js file.

```
npx hardhat run scripts/interact.js --network rinkeby
```

You will see something like this.

```
the message is Hello World! Bingo
the new message is Good Bye, World!
```

Massive congrats! You have made it! You are done. In this course, we learned about:

1.  Setting up MetaMask
    1.  Switching Networks
    2.  Getting some Fake eth
2.  Setting up Alchemy App
3.  Writing your first contract
4.  Deploying your solidity contract
5.  Interacting with your contract

### Assignment

#### ⛺️ Coding Camp Progress

Wohoo!! Share screenshot of your console with updated message here and on Discord.

**Your response is**
