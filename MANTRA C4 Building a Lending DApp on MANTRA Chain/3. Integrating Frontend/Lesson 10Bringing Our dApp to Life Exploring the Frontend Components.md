# Bringing Our dApp to Life: Exploring the Frontend Components

In this lesson, we'll examine the core functionality of our lending dApp's main components. We'll focus on the essential logic and state management while understanding how these components interact with our blockchain through the `useLendingContract` hook.

## Part 1: Home Page Implementation

Let's start by looking at our `Home.jsx` file present inside `/interface/src/pages` folder. The home page serves as the entry point, providing protocol overview and access to core functions. 

```jsx
// Import statements
import { useEffect, useState } from "react";
import { useLendingContract } from "../hooks/useLendingContract";
// ... other UI component imports

export default function Home() {
// Core state management
  const { getPoolInfo } = useLendingContract();
  const [poolInfo, setPoolInfo] = useState(null);

// Data fetching implementation
  useEffect(() => {
    const fetchPoolInfo = async () => {
      const info = await getPoolInfo();
      setPoolInfo(info);
    };
    fetchPoolInfo();
  }, [getPoolInfo]);

// Balance display utility
  const displayBalance = (balanceStr) => {
    if (!balanceStr || balanceStr === '0') return '0';
    try {
      return (Number(balanceStr) / 1000000).toFixed(6);
    } catch (error) {
      return '0';
    }
  };

// JSX rendering with protocol statistics and navigation
}
```

This is where users can stake their USD. Let's break it down:

1. We're using our `useLendingContract` hook to get the `stake` function and `loading` state.
2. We're keeping track of the user's USD balance and the amount they want to stake.
3. We have a function to check the user's USD balance when the component loads.
4. The `handleStake` function is called when the user clicks the "Stake" button. It tries to stake the entered amount and shows a success or error message.
5. We're rendering an input for the user to enter the amount and a button to submit.
    
    ![Screenshot 2024-11-21 173652.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%2010%20Bringing%20Our%20dApp%20to%20Life%20Exploring/Screenshot_2024-11-21_173652.webp?raw=true)
    

## Part 2: Stake Component

Now, let's check out our `Stake.jsx` file present inside `/interface/src/pages` folder. The stake component handles collateral management functionality.

```jsx
// Import statements
import { useState, useEffect, useCallback } from "react";
import { useLendingContract } from '../hooks/useLendingContract';
// ... other imports

export default function Stake() {
// Core hooks and state
  const { data: account } = useAccount();
  const {
    stake,
    getTokenBalance,
    getTokenAllowance,
    approveToken,
    getUserInfo,
    getPoolInfo
  } = useLendingContract();

// State declarations for balances and processing status

// Data refresh implementation
  const refreshData = useCallback(async () => {
    if (!account?.bech32Address) return;
    try {
      const [balance, info, pool] = await Promise.all([
        getTokenBalance(USD_TOKEN_ADDRESS),
        getUserInfo(),
        getPoolInfo()
      ]);
// Update states with fetched data
    } catch (error) {
      console.error("Error refreshing data:", error);
    }
  }, [account?.bech32Address, getTokenBalance, getUserInfo, getPoolInfo]);

// Polling setup
  useEffect(() => {
    refreshData();
    const interval = setInterval(refreshData, 10000);
    return () => clearInterval(interval);
  }, [refreshData]);

// Staking handler
  const handleStake = useCallback(async () => {
// Amount validation// Token approval check and processing// Staking execution// State updates and error handling
  }, [stake, amount, getTokenAllowance, approveToken, refreshData]);

// Utility functions for calculations and display
  const calculateUtilization = () => {
    if (!poolInfo) return 0;
    const totalStaked = Number(poolInfo.total_staked);
    return totalStaked === 0 ? 0 : (Number(poolInfo.total_borrowed) / totalStaked) * 100;
  };

// JSX rendering with statistics and staking interface
}
```

Let's break down how this component works:

1. We're using several functions from our `useLendingContract` hook to handle all staking operations and data fetching.
2. We've implemented a refresh mechanism that updates balances and pool information every 10 seconds.
3. The component manages token approvals before staking, ensuring smooth transactions.
4. We calculate utilization rates to show users how much of the pool is being used.
5. Everything is wrapped in a clean interface that shows both user and pool statistics.
    
    ![Screenshot 2024-11-21 173717.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%2010%20Bringing%20Our%20dApp%20to%20Life%20Exploring/Screenshot_2024-11-21_173717.webp?raw=true)
    

## Part 3: BorrowRepay Component

Last but not least, let's look at our `BorrowRepay.jsx` file present inside `/interface/src/pages` folder. The BorrowRepay component manages lending operations and position management.

```jsx
// Import statements
import { useState, useEffect, useCallback } from "react";
import { useLendingContract } from '../hooks/useLendingContract';
// ... other imports

export default function BorrowRepay() {
// Core hooks and state management
  const { data: account } = useAccount();
  const {
    borrow,
    repay,
    getTokenBalance,
    getUserInfo,
    getPoolInfo,
    calculateInterest,
    calculatePartialRepayment
  } = useLendingContract();

// State declarations for amounts, balances, and user information
  const [principalAmount, setPrincipalAmount] = useState('');
  const [totalRepayAmount, setTotalRepayAmount] = useState('0');
  const [userInfo, setUserInfo] = useState(null);
  const [poolInfo, setPoolInfo] = useState(null);
  const [interestAmount, setInterestAmount] = useState('0');

// Data refresh implementation
  const refreshData = useCallback(async () => {
    if (!account?.bech32Address) return;
    try {
      const [balance, info, pool] = await Promise.all([
        getTokenBalance(OM_TOKEN_ADDRESS),
        getUserInfo(),
        getPoolInfo()
      ]);

// Update states and calculate interest
      if (info && info.borrowed_amount !== '0') {
        const interest = calculateInterest(info.borrowed_amount);
        setInterestAmount(interest.toString());
      }
    } catch (error) {
      console.error("Error refreshing data:", error);
    }
  }, [account?.bech32Address, getTokenBalance, getUserInfo, getPoolInfo, calculateInterest]);

// Core lending calculations
  const calculateMaxBorrow = useCallback(() => {
    if (!userInfo || !poolInfo) return '0';
    const stakedAmount = BigInt(userInfo.staked_amount);
    const collateralRatio = 80n;// 80%
    return (stakedAmount * collateralRatio / 100n).toString();
  }, [userInfo, poolInfo]);

// Amount change handler with interest calculation
  const handlePrincipalAmountChange = useCallback((e) => {
    const principal = e.target.value;
    setPrincipalAmount(principal);

    if (principal && Number(principal) > 0) {
      const smallestUnitPrincipal = (Number(principal) * 1000000).toString();
      const repaymentInfo = calculatePartialRepayment(smallestUnitPrincipal);
      setTotalRepayAmount((Number(repaymentInfo.total) / 1000000).toFixed(6));
      setInterestAmount(repaymentInfo.interest);
    }
  }, [calculatePartialRepayment]);

// Transaction handlers
  const handleBorrow = useCallback(async () => {
// Amount validation// Maximum borrow calculation// Borrow execution// State updates
  }, [borrow, principalAmount, calculateMaxBorrow, refreshData]);

  const handleRepay = useCallback(async () => {
// Amount validation// Balance checks// Repayment execution// State updates
  }, [repay, principalAmount, totalRepayAmount, refreshData]);

// Health monitoring
  const calculateHealthFactor = () => {
    if (!userInfo || BigInt(userInfo.borrowed_amount) === 0n) return 100;
    const collateralValue = BigInt(userInfo.staked_amount);
    const borrowedValue = BigInt(userInfo.borrowed_amount);
    return Number((collateralValue * 100n) / (borrowedValue * 80n));
  };
// JSX rendering with position overview, borrow/repay interface
}
```

Here's what's happening in this component:

1. We're using our lending contract hook for borrowing, repaying, and calculating interest rates.
2. We're tracking multiple states including principal amounts, interest, and user positions.
3. The component calculates maximum borrowing limits based on collateral ratios.
4. We've implemented real-time health factor monitoring to keep positions safe.
5. The interface handles both borrowing and repaying with automatic interest calculations.
    
    ![Screenshot 2024-11-21 173735.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/mantra%20c4%20Building%20a%20Lending%20DApp%20on%20MANTRA%20Chain/Lesson%2010%20Bringing%20Our%20dApp%20to%20Life%20Exploring/Screenshot_2024-11-21_173735.webp?raw=true)
    

### Common Features Across Components:

```jsx
// Shared utility functions
const displayBalance = (balanceStr) => {
  if (!balanceStr || balanceStr === '0') return '0';
  return (Number(balanceStr) / 1000000).toFixed(6);
};

// Error handling
const showToast = (message, status) => {
  toast({
    title: status === "error" ? "Error" : "Success",
    description: message,
    status: status,
    duration: 5000,
    isClosable: true
  });
};

// Data refresh pattern
useEffect(() => {
  refreshData();
  const interval = setInterval(refreshData, 10000);
  return () => clearInterval(interval);
}, [refreshData]);
```

This architecture ensures:

- Consistent data refresh patterns
- Uniform error handling
- Standardized balance display
- Coordinated state management
- Proper cleanup on unmount

Together, these components create a cohesive lending platform where:

1. Home provides protocol overview and navigation
2. Stake manages collateral positions
3. BorrowRepay handles lending operations and position management

Each component maintains its own state while sharing common patterns for data management and user interaction. The architecture emphasizes safety, real-time updates, and clear user feedback throughout all operations.

## Wrapping Up

And there you have it! We've just toured the three main components of our dApp's interface. From the welcoming Home page to the financial functionalities in Stake and BorrowRepay, we've seen how our blockchain interactions translate into a user-friendly interface.

In our next lesson, we'll be looking at the `App.jsx` file. This is where we'll tie everything together, set up our routing, and create the overall structure of our application. Get ready to see how all these pieces fit into one cohesive dApp! Keep up the great work, and see you in the next lesson! 🚀