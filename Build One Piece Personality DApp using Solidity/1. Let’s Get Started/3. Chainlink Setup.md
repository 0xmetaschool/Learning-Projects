# Integrating Chainlink VRF on Arbitrum Sepolia

Welcome to this exciting lesson on integrating **Chainlink VRF (Verifiable Random Function)** into your smart contract on **Arbitrum Sepolia**. By the end of this module, you will have a fully functional randomness setup, crucial for fair draws, lotteries, and unpredictable outcomes in blockchain applications. Let's dive in!

## Step 1: Connecting Your Wallet & Retrieving VRF Details

To get started, follow these steps:

1. Open [Chainlink VRF](https://vrf.chain.link/arbitrum-sepolia) in your browser.
2. Click **Connect Wallet** and authorize your **MetaMask** connection.
3. Locate and copy the **VRF Coordinator Address**, then replace `<your-chainlink-vrf_address-id>` in your `.env` file.

    ![VRF Coordinator](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Secure%20Your%20Data/chainlink-1.webp?raw=true)

4. Similarly, copy the **Key Hash** and replace `<your-chainlink-key_hash-id>` in the `.env` file.

    ![Key Hash](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Secure%20Your%20Data/chainlink-2.webp?raw=true)

## Step 2: Creating & Managing Your Subscription

Chainlink VRF requires a subscription to function. Let's create one!

1. Click **Create Subscription** and follow the prompts:
   - Click **Create Subscription**.
   
     ![Create Subscription](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Secure%20Your%20Data/chainlink-3.webp?raw=true)
   
   - Sign and confirm the transaction.
   
     ![Sign Transaction](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Secure%20Your%20Data/chainlink-3.webp?raw=true)

2. Navigate to **Home > My Subscriptions**. Find your newly created subscription and copy the **Subscription ID**.

    ![Subscription ID](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Secure%20Your%20Data/chainlink-4.webp?raw=true)

3. Update your `.env` file by replacing `<your-chainlink-vrf-subscription-id>` with the copied ID.

    ![Update .env](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Secure%20Your%20Data/chainlink-5.webp?raw=true)

## Step 3: Funding Your Subscription

Before making VRF requests, we need to **fund the subscription**. Here's how:

1. Click **Action > Fund Subscription**.

    ![Fund Subscription](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Secure%20Your%20Data/fund-subscription-1.webp?raw=true)

2. Click **Visit the Chainlink Arbitrum Sepolia Faucet** and request **25 test LINK**.

    ![Request LINK](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Secure%20Your%20Data/fund-subscription-3.webp?raw=true)

3. Return to **Subscription Page**, enter **15 LINK** in **Add Funds**, and click **Confirm**.

    ![Confirm Funds](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/one-piece-dapp/Secure%20Your%20Data/fund-subscription-4.webp?raw=true)

## Wrap-up & Next Steps

Fantastic work! 🎉 You've successfully set up **Chainlink VRF** and funded your subscription. This ensures that your smart contract can now request **random numbers in a secure and verifiable way**.

In the next lesson, we'll **integrate Chainlink VRF into a Solidity smart contract** to generate truly random numbers on-chain. Get ready for some hands-on coding action!

🚀 **See you in the next lesson!**
