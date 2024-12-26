# Set Up the Frontend

Welcome back, folks! Great work on deploying the contracts. Now, we will use the metadata of our deployed contracts to connect with the frontend. We have already built the frontend for you to save you from the hassle. So let’s set it up in this lesson.

Navigate to the `erc404-nftmarketplace-boilerplate` hardhat project and find the `frontend` folder. This folder contains the frontend for our marketplace project. 

## Connect the frontend

Before running the frontend, we need to connect our hardhat project with the frontend. To do this, after deploying the contracts, navigate to the `erc404-nftmarketplace-boilerplate/artifacts` folder and copy the following files:

1. `/artifacts/contracts/Interface/IDN404.sol/IDN404.json`
2. `/artifacts/contracts/NFTMarketplace.sol/NFTMarketplace.json`
3. `/artifacts/contracts/Token.sol/NFTMintDN404.json`

Now, paste these files into the `frontend/src/contracts` folder.

**Note:** Please notice the path of the files we have given above. Please make sure to copy the right file. Also, without the deployment, you will not find these files in your `erc404-nftmarketplace-boilerplate` hardhat project.

## Set up the environment variables file

Move to the `frontend/src/components/ConnectWallet.js`and update the following environment variables with the addresses you got after deploying the contracts.

```
const marketplaceAddress = "YOUR_MARKETPLACE_ADDRESS";
const nftContractAddress = "YOUR_NFT_CONTRACT_ADDRESS";
```

## Set up the frontend

Before running the frontend, we need to install the dependencies. Move to the `frontend` folder in your terminal and run the following commands.

```
npm install --force
```

## Run the frontend

Run the following command to run the frontend.

```
npm start
```

Your frontend will look like this.

![frontend.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_erc404/5%20Work%20With%20the%20Frontend/Set%20Up%20the%20Frontend/frontend.webp?raw=true)

## That’s a wrap

Your frontend is ready to go. Connect your Mumbai network with it using the MetaMask wallet using the same address you used in the deployment lesson. Next, we will interact with it.