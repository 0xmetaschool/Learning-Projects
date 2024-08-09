# Deploy Our Code

Welcome!! So finally we are done with the prerequisites to deploy our code. Let’s quickly dive into running our commands to deploy the contracts.

## Update hardhat.config file

Go to `hardhat.config` file and replace the existing content with the following:

```
require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-verify");

/** @type import('hardhat/config').HardhatUserConfig */

const dotenv = require("dotenv");
dotenv.config();

function privateKey() {
  return process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [];
}

module.exports = {
  networks: {
    hardhat: {
      initialDate: "1970-01-01T00:00:00Z",
      accounts: {
        accountsBalance: "1000000000000000000000000000000",
      },
      hardfork: "berlin",
    },
    amoy: {
      url: "https://rpc-amoy.polygon.technology/",
      accounts: privateKey(),
    }
  },
  solidity: "0.8.20",
  etherscan: {
    apiKey: "S1VXKDQCP4P2VXAK9Q8B46K71TFP9WF692",
  },
};
```

Now we will first compile our files by running the following command:

```
npx hardhat compile
```

The output will be like the following:

![Frame 3560381.jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_erc404/4%20Deploy%20the%20MarketPlace/Deploy%20Our%20Code/Frame_3560381.jpg?raw=true)

## Deploy the contracts

Now run the following commands:

```
npx hardhat run scripts/deployToken.js --network amoy
npx hardhat run scripts/deployMarketplace.js --network amoy
```

Here’s the output:

![Frame 3560381 (1).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_erc404/4%20Deploy%20the%20MarketPlace/Deploy%20Our%20Code/Frame_3560381_(1).jpg?raw=true)

## Wrap up

In this lesson, we've walked through the process of deploying our code contracts. This included updating the `hardhat.config` file, compiling our files, and finally deploying the contracts. Hopefully, this has provided you with a practical understanding of how code deployment works. 

In the next lesson, we will work on the frontend so we can interact with our code.
