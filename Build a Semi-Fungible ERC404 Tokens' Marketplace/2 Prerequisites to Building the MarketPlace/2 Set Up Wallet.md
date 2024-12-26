# Set Up Wallet

Greetings folks! Great work coming this far. Now, we will dive into setting up a few things so stay with us!

## MetaMask

We need a wallet to proceed so if you have not installed MetaMask, just install the [MetaMask Chrome extension](https://chromewebstore.google.com/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn). 

## Setting up the testnet environment

Next, we will opt for the Mumbai network to deploy our code. To set it up, complete the following steps:

- Head over to [https://chainlist.org/chain/80001](https://chainlist.org/chain/80001).
- Click on “Connect Wallet”.
- Click on Next, then Connect, then Approve, and finally Switch Network.
- After connecting your wallet, click on “Add to Metamask”.
- Click on Approve and then Switch Network.

You will be successfully connected to the Mumbai network. See in the following gif how I did it:

![Screen Recording 2023-08-02 at 7.19.24 PM.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_erc404/2%20Prerequisites%20to%20Building%20the%20MarketPlace/2%20Set%20Up%20Wallet/Screen_Recording_2023-08-02_at_7.19.24_PM.webp?raw=true)

### Get some fake MATIC $$ 🤑

Now it's time to get some money! 

- Copy your account address.
- Head over to [https://faucet.polygon.technology/](https://faucet.polygon.technology/).
- Paste your wallet address.

See in the following gif how I did it:

![Frame 3560365 (7).gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_erc404/2%20Prerequisites%20to%20Building%20the%20MarketPlace/2%20Set%20Up%20Wallet/Frame_3560365_(7).webp?raw=true)

This fake money will be used for deploying your contract and doing transactions on your contract. This is not real money, you can’t buy NFTs, or other assets via these MATIC.

## Get your private 🦊 MetaMask key

While writing and deploying your contract you sign off each contract with your private key to tell the blockchain that you are a legit person creating a real transaction. Complete the following steps to find your private key:

- Open the Metamask extension.
- Click on your Account.
- Click on 3 dots and then Account Details.
- Click on “Show private key”.
- Enter your password and hit Confirm.
- Copy your private key.

See in the following gif how I did it:

![Screen Recording 2023-08-02 at 7.28.24 PM.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_erc404/2%20Prerequisites%20to%20Building%20the%20MarketPlace/2%20Set%20Up%20Wallet/Screen_Recording_2023-08-02_at_7.28.24_PM.webp?raw=true)

Your private key is super important and should be secured. So be extra vigilant in keeping it that way. Next, I’ll tell you how to keep your account and private key safe.

## Create `.env` file

Now create a `.env` file in your folder of `erc404-nftmarketplace-boilerplate` and paste the following into the file. Yes. Your file name would be `.env`! Replace `<YOUR_PRIVATE_KEY>` with the one you copied from your Metamask.

```
PRIVATE_KEY=<YOUR_PRIVATE_KEY>
```

## That’s a wrap

You have set up your environment. Now you are ready to build the marketplace and work with the DN404 contract that we have already added for you in our boilerplate project.