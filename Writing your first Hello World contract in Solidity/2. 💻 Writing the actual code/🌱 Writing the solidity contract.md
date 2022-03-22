# 💻 Writing the actual code

## **🌱 Writing the solidity contract**

We are getting to the meat of this project. Now we will write the code. I hope you have already installed Node to your machine, and have VScode installed.

1.  Install [node from here](https://nodejs.org/en/).
2.  Download [VScode](https://code.visualstudio.com/)

Open the terminal and run the following commands.

```
mkdir Hello-World
cd Hello-World
ls
npm init --yes
npm install --save-dev hardhat
npx hardhat
```

When you run the last command, you will get an option to create an Empty project with hardhat config. Do pick that and you will see something like this.

```
888    888                      888 888               888
888    888                      888 888               888
888    888                      888 888               888
8888888888  8888b.  888d888 .d88888 88888b.   8888b.  888888
888    888     "88b 888P"  d88" 888 888 "88b     "88b 888
888    888 .d888888 888    888  888 888  888 .d888888 888
888    888 888  888 888    Y88b 888 888  888 888  888 Y88b.
888    888 "Y888888 888     "Y88888 888  888 "Y888888  "Y888
 
👷 Welcome to Hardhat v2.8.4 👷‍
 
✔ What do you want to do? · Create an empty hardhat.config.js
✨ Config file created ✨
```

Now let's open in project in VScode. Open the Hardhat config file.

**✨  Side tip: Install Solidity Extension in VScode to help with syntax and coding error issues.**

```
/**
* @type import('hardhat/config').HardhatUserConfig
*/
module.exports = {
 solidity: "0.7.3",
};
```

There is not much going on here except for we are mentioning the version of solidity we are using.

#### Creating Directories for Code

Now we will create two directories, contracts, scripts.

The contracts directory will have all the contracts for the project and scripts directory will have all the deployments scripts and other stuff related to the project. By now the structure of your project will look something like this.

```
HelloWorld
> contracts
> node_modules
> scripts
hardhat.config.js
package-lock.json
Package.json
```

The contracts directory will have the contract of your Hello World. Create a HelloWorld.sol file in the contracts folder and write the following code.

```
/SPDX-License-Identifier: UNLICENSED
 
pragma solidity >= 0.7.3;
 
contract HelloWorld {
    //events
    //states
    //functions
 
    event messagechanged(string oldmsg, string newmsg);
 
    string public message;
 
    constructor(string memory firstmessage) {
        message = firstmessage;   
    }
 
    function update(string memory newmesssage) public {
        string memory oldmsg = message;
        message = newmesssage;
 
        emit messagechanged(oldmsg, newmesssage);
 
    }
}
```

We start with mentioning the version of the solidity that we are using and then write the actual contract. A smart contract has states, functions and events.

-   The states are usually variables, tokens, NFTs whose state we want to maintain in the contract.
-   In order to read, write or change the states, we use functions.
-   Events are triggers that are activated based on a transformation in a state, a call to a function etc. So our code right now has a state variable called ‘message’, a function called ‘update’ and and event called ‘messagechanged’.

This is a basic HelloWorld code that takes a string when the smart contract is first time executed and if we want we can change that value to a new message as well.

Now that we have written the contract, the next step is to prepare for the deployment.

### Assignment

#### ⛺️ Coding Camp Progress

If you are following everything properly so far, send a question or comment in ⛺️ | CodingCamp discord channel. Plsssssssssssss

**Your response is**
