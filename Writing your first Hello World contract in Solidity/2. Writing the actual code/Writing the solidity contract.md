# Writing The Solidity Contract

Welcome back! So far, you have set up your wallet. Now, we are getting to the meat of this project. In this lesson, we will write code. I hope you have already installed Node to your machine, and have VScode installed.

## Creating the Solidity contract

The contracts directory will have the contract of your Hello World program. Delete the exsiting `contracts/lock.sol` file, create a `HelloWorld.sol` file in the `contracts` folder and write the following code.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HelloWorld {
    // State variable - stored on blockchain
    string public message;

    // Constructor - runs once when contract is deployed
    constructor() {
        message = "Hello World!";
    }

    // Function to get the message
    function getMessage() public view returns (string memory) {
        return message;
    }

    // Function to set a new message
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }
}
```

We start with mentioning the version of the solidity that we are using and then write the actual contract. A smart contract has states, functions and events.

- The states are usually variables, tokens, NFTs whose state we want to maintain in the contract.
- In order to read, write or change the states, we use functions.
- Events are triggers that are activated based on a transformation in a state, a call to a function etc. So our code right now has a state variable called `message`, a function called `update` and and event called `messagechanged`.

This is a basic `HelloWorld` code that takes a string when the smart contract is first time executed and if we want we can change that value to a new message as well.

Now that we have written the contract, the next step is to prepare for the deployment.

## That's a wrap

And if all that is done, congrats, you have a smart contract ready to go. Yasss!! 🚀 A basic sample JavaScript project is created for you and you can execute your first ever smart contract.

Now, in next lesson, you will do some set ups to run your project smoothly and deploy your contract to your MetaMask contract address.
