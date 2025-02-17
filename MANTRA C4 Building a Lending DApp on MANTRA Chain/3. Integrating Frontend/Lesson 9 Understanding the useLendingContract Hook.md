# Understanding the useLendingContract Hook

## Building Our Smart Lending Hook! 🎣

Hey there, fellow coder! 👋 Ready to dive into the exciting world of our `useLendingContract` hook? This little powerhouse is what makes our dApp tick, so let's break it down piece by piece. Grab your favorite beverage, and let's get started!

## Setting the Stage

First, let's check out what we're importing in our `useLendingContract` file in `/interface/src/hooks`:

```tsx
import { useCallback, useState } from 'react';
import { useAccount, useCosmWasmClient } from "graz";
import { SigningCosmWasmClient } from "@cosmjs/cosmwasm-stargate";
import { CONTRACT_ADDRESS, USD_TOKEN_ADDRESS, OM_TOKEN_ADDRESS } from '../chain';
import { GasPrice } from "@cosmjs/stargate";

```

These imports are our toolkit for blockchain magic:

- React hooks for optimization and state management
- Graz hooks for blockchain interaction
- CosmWasm utilities for smart contract communication
- Our contract addresses and gas price handling

## The Hook Foundation

Let's set up our basic hook structure:

```tsx
export function useLendingContract() {
  const { data: account } = useAccount();
  const { data: cosmWasmClient } = useCosmWasmClient();
  const [loading, setLoading] = useState(false);

```

Think of this as our command center:

- `account`: Your blockchain identity card
- `cosmWasmClient`: Our phone line to the blockchain
- `loading`: Our "Please Wait" sign

## Signing Client Setup

```tsx
const getSigningClient = useCallback(async () => {
  if (!window.keplr) throw new Error("Keplr not found");
  await window.keplr.enable("mantra-dukong-1");
  const offlineSigner = window.keplr.getOfflineSigner("mantra-dukong-1");
  const gasPrice = GasPrice.fromString('0.025uom');
  return await SigningCosmWasmClient.connectWithSigner(
    "<https://rpc.dukong.mantrachain.io>",
    offlineSigner,
    { gasPrice }
  );
}, []);

```

This is like getting our special blockchain pen ready:

1. Checks for Keplr wallet
2. Connects to Mantra testnet
3. Sets up our transaction signer
4. Configures gas prices
5. Creates our signing client

## Pool and User Information

Here's how we check what's happening in our lending pool:

```tsx
const getPoolInfo = useCallback(async () => {
  try {
    if (!cosmWasmClient) return null;
    const result = await cosmWasmClient.queryContractSmart(CONTRACT_ADDRESS, {
      get_pool_info: {}
    });
    console.log('Pool info:', result);
    return result;
  } catch (error) {
    console.error('Get pool info error:', error);
    return null;
  }
}, [cosmWasmClient]);

const getUserInfo = useCallback(async () => {
  try {
    if (!account?.bech32Address || !cosmWasmClient) return null;

    const result = await cosmWasmClient.queryContractSmart(CONTRACT_ADDRESS, {
      get_user_info: {
        address: account.bech32Address
      }
    });

    console.log('User info result:', result);
    return result;
  } catch (error) {
    console.error("Error getting user info:", error);
    return null;
  }
}, [account?.bech32Address, cosmWasmClient]);

```

These functions are like checking the pool's dashboard and your personal account:

- `getPoolInfo`: Gets overall lending pool statistics
- `getUserInfo`: Retrieves your personal lending/borrowing status

## Token Balance and Allowance Checking

Let's see how we check our tokens and permissions:

```tsx
const getTokenBalance = useCallback(async (tokenAddress) => {
  try {
    if (!account?.bech32Address || !cosmWasmClient) {
      console.log('Missing account or client');
      return '0';
    }

    const result = await cosmWasmClient.queryContractSmart(tokenAddress, {
      balance: {
        address: account.bech32Address
      }
    });

    return result.balance;
  } catch (error) {
    console.error('Get balance error:', error);
    return '0';
  }
}, [account?.bech32Address, cosmWasmClient]);

const getTokenAllowance = useCallback(async (tokenAddress) => {
  try {
    if (!account?.bech32Address || !cosmWasmClient) return '0';

    const result = await cosmWasmClient.queryContractSmart(tokenAddress, {
      allowance: {
        owner: account.bech32Address,
        spender: CONTRACT_ADDRESS
      }
    });

    return result.allowance;
  } catch (error) {
    console.error('Get allowance error:', error);
    return '0';
  }
}, [account?.bech32Address, cosmWasmClient]);

```

These are like checking your wallet and spending limits:

- `getTokenBalance`: Shows how many tokens you have
- `getTokenAllowance`: Checks how much the contract can spend

## Token Approval System

```tsx
const approveToken = useCallback(async (tokenAddress, amount) => {
  if (!account?.bech32Address) throw new Error("No account connected");
  setLoading(true);
  try {
    const signingClient = await getSigningClient();
    const result = await signingClient.execute(
      account.bech32Address,
      tokenAddress,
      {
        increase_allowance: {
          spender: CONTRACT_ADDRESS,
          amount: amount
        }
      },
      "auto"
    );
    console.log('Approval result:', result);
    return result;
  } catch (error) {
    console.error('Approve error:', error);
    throw error;
  } finally {
    setLoading(false);
  }
}, [account?.bech32Address, getSigningClient]);

```

This function is like giving the contract permission to use your tokens:

1. Checks if you're connected
2. Gets the signing client ready
3. Increases the contract's spending allowance

## Interest Calculations

```tsx
const calculateInterest = useCallback((amount) => {
  if (!amount || BigInt(amount) === 0n) return '0';
  const principal = BigInt(amount);
  return (principal * BigInt(1000)) / BigInt(10000); // 10% interest
}, []);

const calculatePartialRepayment = useCallback((principalAmount) => {
  if (!principalAmount || Number(principalAmount) <= 0) return {
    principal: '0',
    interest: '0',
    total: '0'
  };

  const principal = BigInt(principalAmount);
  const interest = calculateInterest(principalAmount);
  const total = principal + BigInt(interest);

  return {
    principal: principal.toString(),
    interest: interest.toString(),
    total: total.toString()
  };
}, [calculateInterest]);

```

These are our math wizards:

- `calculateInterest`: Figures out interest (10% rate)
- `calculatePartialRepayment`: Breaks down repayment into principal and interest

## Core Lending Operations

### Staking Function

```tsx
const stake = useCallback(async (amount) => {
  if (!account) return;
  setLoading(true);
  try {
    const signingClient = await getSigningClient();
    const amountToStake = BigInt(amount);

    const stakeMsg = btoa(JSON.stringify({ stake: {} }));

    const result = await signingClient.execute(
      account.bech32Address,
      USD_TOKEN_ADDRESS,
      {
        send: {
          contract: CONTRACT_ADDRESS,
          amount: amountToStake.toString(),
          msg: stakeMsg
        }
      },
      "auto"
    );

    await new Promise(resolve => setTimeout(resolve, 1000));
    await Promise.all([getPoolInfo(), getUserInfo()]);

    return result;
  } catch (error) {
    console.error("Error staking:", error);
    throw error;
  } finally {
    setLoading(false);
  }
}, [account, getSigningClient, getPoolInfo, getUserInfo]);

```

This is how we put our tokens to work:

1. Prepares the staking amount
2. Creates a base64 encoded message
3. Sends tokens to the contract
4. Updates pool and user info

### Borrowing Function

```tsx
const borrow = useCallback(async (amount) => {
  if (!account) return;
  setLoading(true);
  try {
    const signingClient = await getSigningClient();
    const amountToBorrow = BigInt(amount);

    const result = await signingClient.execute(
      account.bech32Address,
      CONTRACT_ADDRESS,
      {
        borrow: {
          amount: amountToBorrow.toString()
        }
      },
      "auto"
    );

    await new Promise(resolve => setTimeout(resolve, 1000));
    await Promise.all([getPoolInfo(), getUserInfo()]);

    return result;
  } catch (error) {
    console.error("Error borrowing:", error);
    throw error;
  } finally {
    setLoading(false);
  }
}, [account, getSigningClient, getPoolInfo, getUserInfo]);

```

This is our loan request system:

1. Validates the borrowing amount
2. Sends the borrow request
3. Waits for confirmation
4. Updates pool and user stats

### Repayment Function

```tsx
const repay = useCallback(async (totalAmount) => {
  if (!account) return;
  setLoading(true);
  try {
    const signingClient = await getSigningClient();
    const amountToRepay = BigInt(totalAmount);

    const userInfo = await getUserInfo();
    if (!userInfo) throw new Error("Could not get user information");

    const maxRepayment = calculatePartialRepayment(userInfo.borrowed_amount);
    if (amountToRepay > BigInt(maxRepayment.total)) {
      throw new Error("Repayment amount exceeds total debt including interest");
    }

    const repayMsg = btoa(JSON.stringify({ repay: {} }));

    const result = await signingClient.execute(
      account.bech32Address,
      OM_TOKEN_ADDRESS,
      {
        send: {
          contract: CONTRACT_ADDRESS,
          amount: amountToRepay.toString(),
          msg: repayMsg
        }
      },
      "auto"
    );

    await new Promise(resolve => setTimeout(resolve, 1000));
    await Promise.all([getPoolInfo(), getUserInfo()]);

    return result;
  } catch (error) {
    console.error("Error repaying:", error);
    throw error;
  } finally {
    setLoading(false);
  }
}, [account, getSigningClient, getPoolInfo, getUserInfo, calculatePartialRepayment]);

```

Our repayment processor:

1. Validates repayment amount
2. Checks against total debt
3. Processes the repayment
4. Updates all relevant information

## Wrapping Up

And there you have it! Our complete `useLendingContract` hook exports all these awesome functions:

```tsx
return {
  stake,
  borrow,
  repay,
  getTokenBalance,
  getUserInfo,
  getTokenAllowance,
  approveToken,
  getPoolInfo,
  calculateInterest,
  calculatePartialRepayment,
  loading
};

```

This hook is like a Swiss Army knife for our lending dApp, handling everything from checking balances to processing loans!

Next up, we'll dive into how these functions come together in our UI components. Get ready to explore `BorrowRepay.jsx`, `Home.jsx`, and `Stake.jsx` - where all this functionality meets user interaction! 🚀