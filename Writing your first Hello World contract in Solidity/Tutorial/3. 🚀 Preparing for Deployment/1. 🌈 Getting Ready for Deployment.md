# 🚀 Preparing for Deployment

## **🌈 Getting Ready for Deployment**

First let’s do some basic housekeeping stuff. We know that there are massive scams and security issues happening in the crypto world. You make a mistake and it can cost you a life time.  
  
While writing and deploying your contract you sign off each contract with your private key to tell the blockchain that you are a legit person creating a real transaction. Now if that private key is made visible, the hacker can gain access to your account and then the rest will be history. In order to avoid this issue. Let’s do the following.

```
npm install dotenv --save
touch .gitignore
```

Now go ahead and create .env file at the base of your project. Open your .gitignore file and write .env there.

All the secrets and important keys related to your project will be stored in .env file and we can access this data whenever and wherever. In the gitignore file we simply write .env, it tells git to ignore that file from future commits.

Open the .env file you have just created. Add your MetaMask Private Key and Alchemy App HTTP URL there. Should be something like this.

```
PRIVATE_KEY=YOUR-PRIVATE-KEY
API_URL_KEY=YOUR-ALCHEMY-APP-URL
API_KEY=YOUR-ALCHEMY-APP-KEY
```

We will update our hardhat config file to setup Rinkeby Deployment.

```
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
require('dotenv').config(); //all the key value pairs are being made available due to this lib
require('@nomiclabs/hardhat-ethers');
 
const {API_URL_KEY, PRIVATE_KEY} = process.env; //environment variables are being loaded here.
 
module.exports = {
  solidity: "0.7.3",
  defaultNetwork: 'rinkeby',
  networks: {
    hardhat: {},
    rinkeby: {
        url: API_URL_KEY,
        accounts: [`0x${PRIVATE_KEY}`]
    }
  }
};
```

### Assignment

#### ⛺️ Coding Camp Progress

Ask a question or leave a comment on Discord ⛺️ | Coding-Camp channel.

**Your response is**
