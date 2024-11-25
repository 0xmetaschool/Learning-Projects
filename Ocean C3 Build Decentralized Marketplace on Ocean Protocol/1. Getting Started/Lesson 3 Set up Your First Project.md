# Set up Your First Project

Alright, it's time to get our hands dirty and start building our very first Ocean Protocol project! In this lesson, we'll shift gears and get everything ready to deploy our dApp to the Sepolia test network. Don't worry, we'll guide you through every step of the way, making sure it's smooth sailing!

## Prerequisites: Your Web3 Toolkit

Before we dive into the project setup, let's make sure you have a few things ready:

1. **MetaMask Wallet:**
    - If you haven't already, head over to the [MetaMask website](https://metamask.io/) and install the extension for your browser.
    - Follow the on-screen instructions to create a new wallet or import an existing one.
    - Remember to keep your seed phrase safe and secure - it's the key to your wallet!
    - Add the Sepolia Testnet to your MetaMask. You can find instructions on how to add Sepolia to MetaMask on various online resources or within MetaMask itself.
2. **Sepolia Testnet Ether (SEP)**
    - Just like in the real world, you need some currency to interact with the blockchain. On the Sepolia testnet, we use testnet Ether (SEP).
    - Luckily, there are faucets that provide free SEP for testing purposes. Head over to the Sepolia Faucet ([https://sepolia-faucet.pk910.de/](https://sepolia-faucet.pk910.de/)) and request some SEP to be sent to your MetaMask address.
3. **Alchemy Account and RPC Endpoint**
    - We need a way to communicate with the Sepolia network. Services like [Alchemy](https://www.alchemy.com/) provide RPC endpoints for this purpose
    - Sign up for a free Alchemy account, create a new app, and select the Sepolia network.
    - Copy the "HTTPS" endpoint URL from your Alchemy dashboard. We'll need this later.

## Setting the Stage: Project Initialization

With our toolkit ready, let's create the foundation for our Ocean Protocol project. Well, Ocean has made it super easy for you, we just need to fork a repo. Let’s see how we can do it.

Open your terminal and navigate to where you want to create your project. Then, run the following commands:

```bash
gh repo fork https://github.com/oceanprotocol/market.git --clone
cd market
```

This creates a cozy new directory named `market` and takes you right into it.

1. **Install node modules:** Run the following command:
    
    ```jsx
    npm install
    ```
    
2. **Run the dApp:** Run the following command:
    
    ```bash
    npm start
    ```
    

You will see the following output. How cool it is, it just took us a fork command!

![ocean-ezgif.com-gif-to-webp-converter.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%203%20Set%20up%20Your%20First%20Project/ocean-ezgif.com-gif-to-webp-converter.webp)

You should also connect your wallet!

![oceanwalletconnect.gif](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/Ocean%20C3%20Build%20Decentralized%20Marketplace%20on%20Ocean%20Protocol/Lesson%203%20Set%20up%20Your%20First%20Project/oceanwalletconnect.webp)

## Wrap Up

Fantastic! You've successfully taken the first step. Now it’s time to make this marketplace yours! We'll dive into customization in the next lesson. Stay tuned!