# Constructor and Operators

Hey, welcome! So excited to see you back. In the last lesson, we laid the groundwork for our Core lending dApp. Now in this lesson, we will dive into two important concepts in Solidity smart contract development: Constructors and Operators. We'll also explore how to use these concepts in practice while building a simple deposit and withdrawal functionality. So why wait, let’s just dive into it right away.

## Quick Checkout

First, let’s quickly swap out our boilerplate with the corresponding frontend for these functionalities.

```solidity
git checkout origin/boilerplate02
```

Don't worry, all the code we’ve written so far will be present in the project. Navigate to the `CoreLoanPlatform.sol` file present inside the `contracts` folder and let’s add the required functions there.

## Constructors: Launching Your Contract

A constructor is a special function in a Solidity contract that gets executed only once during the initial deployment of the contract. It's like the setup phase for your contract, where you can initialize important variables or perform essential actions.

**Key Points to Remember:**

- One constructor per contract guarantees a consistent starting point.
- Constructor code initializes the contract state (variables) during deployment.
- Public constructors allow anyone to deploy, while internal ones restrict deployment for internal use (like abstract classes).
- Deployed code only includes public functions and code reachable through them, not the constructor itself.
- A default empty constructor is provided if you don't define one.

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXeeEs0B7gpm-XvLuu24FrHr6PHb-Nrv_y9pMsyKFTRgMNKbxMVlUJJmJ4VNISGuvxTb3TVzh6GMd7io40rgZ8l6vBDGDSoB4EquscmKAz4yMgKNvingnRnSq3J6JXNoOGxu984ePXOFg69HzZWr8Ig0k8_q?key=SvvLSoKwwYsKbkLRxbp6Ww)

### Initializing state variables

The primary purpose of a constructor is to assign initial values to your contract’s state variables. These variables hold the data that defines the current state of your smart contract. By initializing them in the constructor, you ensure they have meaningful values from the get-go.

For example, in our lending dApp, we want to deposit USD as collateral to borrow BTC tokens. It means we need addresses at the beginning, where we can initialize the address from, where we have to fetch the USD, and an address where we have to transfer the BTC tokens. These addresses have to be initialized in the constructor.

Constructors can also be defined to accept arguments. This allows you to provide custom initial values during deployment. Just like we need for our Lending dApp.

Navigate to `build-lending-dapp-on-core/contracts/CoreLoanPlatform.sol`. We can write up the code as:

```solidity
constructor(address _USD, address _BTC) Ownable(msg.sender) {

	require(_USD != address(0) && _BTC != address(0), "Invalid token addresses");
	USD = IERC20(_USD);
	BTC = IERC20(_BTC);

}
```

This initializes the contract by setting the deployer as the owner using the `Ownable` constructor. It checks that the provided USD and BTC token addresses are not zero addresses, ensuring they are valid. If valid, it assigns these addresses to the `USD` and `BTC` state variables, casting them to the `IERC20` interface to allow interaction with the respective token contracts. This setup ensures the contract can manage USD and BTC tokens securely.

## Faucet Code Functions

We did discuss in our last lesson about our Tokens: USD and BTC. Here we will discuss how the faucet works where we will be using the mint function of our USD and BTC contracts which are the twomock currencies we will be using for testing. We have already added the files in our git but let’s discuss them here.

### USD.sol

We define a smart contract named "USD" that adheres to the ERC-20 standard and includes ownership and permit functionalities from OpenZeppelin's libraries. The contract inherits from `ERC20`, `Ownable`, and `ERC20Permit`. In the constructor, it initializes the token with a name and symbol, sets the contract deployer as the owner, and establishes the permit functionality. The contract includes a mint function, allowing new tokens to be minted to a specified address, with the constraint that the amount must not exceed 100 tokens (with 18 decimal places).

The code for this is as follows:

```solidity
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract USD is ERC20, Ownable, ERC20Permit {
	constructor(string memory name, string memory symbol)
			ERC20(name, symbol)
			Ownable(msg.sender)
			ERC20Permit(name)
	{}
	
	function mint(address to, uint256 amount) public {
		require(amount <= 100 * 10 ** 18, "amount must be less than 100");
		_mint(to, amount);
	}

}
```

### Bitcoin.sol

We define a smart contract named "Bitcoin" that follows the ERC-20 standard and includes ownership and permit functionalities from OpenZeppelin's libraries. The contract inherits from `ERC20`, `Ownable`, and `ERC20Permit`. The constructor initializes the token with a given name and symbol, sets the deployer as the owner, and sets up the permit functionality. The contract includes a `mint` function, which allows new tokens to be minted to a specified address, but restricts the minting amount to a maximum of 10 tokens (with 18 decimal places).

The code for this is as follows:

```solidity
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract Bitcoin is ERC20, Ownable, ERC20Permit {
	constructor(string memory name, string memory symbol)
		ERC20(name, symbol)
		Ownable(msg.sender)
		ERC20Permit(name)
	{}
	
	function mint(address to, uint256 amount) public {
		require(amount <= 10 * 10 ** 18, "amount must be less than 10");
		_mint(to, amount);
	}

}
```

Now whenever you click on the faucet button in the frontend, the mint function of both the BTC and USD contracts are called to mint 10 and 100 tokens respectively to your wallet address

Okay, let’s learn about operators since we will use them in our code.

## Arithmetic Operators

Arithmetic operators are used to perform mathematical operations. Common arithmetic operators in Solidity include:

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXfnOS7Zkf11l2D00uaWdpuJJBkWzIlpjk_bHgbRDGvOxmayas29CS5aESoLSq2W4j2qKwYJ8y5Qwj_B28eapx_mMsu-FP7Kiwfs80aceqgInovEFfcclqHKIkZlarztTFScfuC_q511As7s03tJc5fEsfmI?key=SvvLSoKwwYsKbkLRxbp6Ww)

## Relational Operators

Relational operators are used to compare values. Common relational operators in Solidity include:

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXcMipBl1aqCmU9qCdxTNBmjPgYHRXnol3zF7k94KKKwnfOmI-nj7N7kyK0hMxNwVYVlrBR7IVqLWGq2QmMKYwqdbRIJzx8S9Sim0FPF-KlYkQjm6iJrCmTC6tETWYQonjrNT1ahO3T9rKuyWauT5V6b9qA-?key=SvvLSoKwwYsKbkLRxbp6Ww)

## Require Statement: Enforcing Conditions

The `require` statement is used to enforce certain conditions in your contract. If the condition evaluated by `require` is not met, the transaction is reverted, and any changes made to the state are undone. This is useful for input validation and ensuring that only valid transactions are processed.

Now, it’s time to put all our knowledge of constructors, operators, and `require` statements into practice and define the functionality of `depositCollateral`, `withdrawCollateral`, `borrowBTC`, and a few other functions.

### depositCollateral

The `depositCollateral` function allows users to deposit a specified amount of USD tokens as collateral. It first ensures the amount is greater than zero, then safely transfers the USD tokens from the user's address to the contract. The user's collateral balance is updated accordingly, and a `CollateralDeposited` event is emitted to log the transaction.

In Solidity, we can use **events** to log information on the blockchain, enabling smart contracts to communicate with external applications. When an event is emitted, it creates a log entry that external applications can listen to and react to. This is useful for notifications, debugging, and enabling interactions between contracts and dApps.

The code for this function is given below, make sure to add it to our code file of `CoreLoanPlatform.sol` under the `function depositCollateral(uint256 amount) external {` placeholder:

```solidity
function depositCollateral(uint256 amount) external  {
	require(amount > 0, "Amount must be greater than 0");
	USD.safeTransferFrom(msg.sender, address(this), amount);
	userCollateral[msg.sender] += amount;
	emit CollateralDeposited(msg.sender, amount);
}
```

### withdrawCollateral

The `withdrawCollateral` function enables users to withdraw a specified amount of USD tokens from their collateral. It first checks that the amount is greater than zero and that the user has sufficient collateral. If the user has an active loan, it ensures that the remaining collateral after withdrawal is enough to cover the required collateral. Upon validation, the user's collateral balance is reduced, the USD tokens are safely transferred to the user, and a `CollateralWithdrawn` event is emitted to log the transaction.

The code for this function is given below, make sure to add it to our code file of `CoreLoanPlatform.sol` under the `function withdrawCollateral(uint256 amount) external {` placeholder:

```solidity
function withdrawCollateral(uint256 amount) external  {
	require(amount > 0, "Amount must be greater than 0");
	require(userCollateral[msg.sender] >= amount, "Insufficient collateral");
	uint256 borrowedAmount = loans[msg.sender].active ? loans[msg.sender].amount : 0;
	uint256 requiredCollateral = (borrowedAmount * COLLATERAL_RATIO) / 100;
	
	require(userCollateral[msg.sender] - amount >= requiredCollateral, "Withdrawal would undercollateralize loan");
	userCollateral[msg.sender] -= amount;
	USD.safeTransfer(msg.sender, amount);
	emit CollateralWithdrawn(msg.sender, amount);
}
```

### borrowBTC

The `borrowBTC` function allows users to borrow a specified amount of BTC tokens. It ensures the requested amount is greater than zero and that the user has no existing active loans. It calculates the required collateral and checks if the user has sufficient collateral. It also ensures the borrowed amount is within the allowable limit based on the user's collateral and that the contract has enough BTC tokens. If all checks pass, it creates a new loan, transfers the BTC to the user, updates the total borrowed amount, and emits a `LoanTaken` event to log the transaction.

The code for this function is given below, make sure to add it to our code file of `CoreLoanPlatform.sol` under the `function borrowBTC(uint256 amount) external {` placeholder:

```solidity
function borrowBTC(uint256 amount) external  {
	require(amount > 0, "Amount must be greater than 0");
	require(!loans[msg.sender].active, "Existing loan must be repaid first");
	
	uint256 requiredCollateral = (amount * COLLATERAL_RATIO) / 100;
	require(userCollateral[msg.sender] >= requiredCollateral, "Insufficient collateral");
	
	uint256 maxBorrowable = (userCollateral[msg.sender] * BORROWABLE_RATIO) / 100;
	require(amount <= maxBorrowable, "Borrow amount exceeds limit");
	require(BTC.balanceOf(address(this)) >= amount, "Insufficient BTC in contract");
	
	loans[msg.sender] = Loan(amount, requiredCollateral, block.timestamp, true);
	BTC.safeTransfer(msg.sender, amount);
	totalBorrowed = totalBorrowed + amount;
	emit LoanTaken(msg.sender, amount, requiredCollateral);
}
```

### Query Helper Functions

Finally, we’ll just add two more functions to our contract that will help us fetch the user’s collateral and borrowable amount.

```solidity
function getBorrowableAmount(address user) external view returns (uint256) {
	return (userCollateral[user] * BORROWABLE_RATIO) / 100;
}

function getUserCollateral(address user) external view returns (uint256) {
	return userCollateral[user];
}
```

This pretty much sums up the basics, let’s deploy and test everything out.

## Let’s try it out

First, let’s create a `.env` in the root directory and paste your private key against the `PRIVATE_KEY` variable.

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXfjNaAKk8pYFSvrMZ9GF616FQSnBKtFKYDDfsUjjxhKWL1Xm2yd2x6nD-NG70z1lSmQzolNwt19_9to4PFvZCqWA68HWyNwTvR7F0yscB-w_rrl91XgM8a1XRVH7LpLgBlx0vVVcNU4Un1xVe9s1K_Kx4N1?key=SvvLSoKwwYsKbkLRxbp6Ww)

### Deployment script

Let’s update our deployment script according to our updated code. Here is how our script will look like now:

```solidity
const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("BTCfi", (m) => {
	const BTC = m.contract("Bitcoin", ["Bitcoin", "BTC"]);
	const USD = m.contract("USD", ["US Dollar", "USD"]);
	const lending = m.contract("CoreLoanPlatform", [USD, BTC]);
	m.call(BTC, "transferOwnership", [lending]);
	m.call(USD, "transferOwnership", [lending]);
	
	return { BTC, USD, lending };
});
```

It defines the deployment of three contracts: `Bitcoin`, `USD`, and `CoreLoanPlatform`. And sets up a basic lending platform where `CoreLoanPlatform` can control the `Bitcoin` and `USD` tokens. Here's a brief explanation:

1. **Define Contracts**: It defines two contracts, `Bitcoin` (with the symbol "BTC") and `USD` (with the symbol "USD"). These contracts are given in the `contracts` folder and they are mock ERC20 tokens that will be dispensed via the faucet in our dApp
2. **Core Loan Platform**: It deploys a `CoreLoanPlatform` contract, initializing it with the `USD` and `BTC` contracts.
3. **Ownership Transfer**: The script then transfers ownership of the `Bitcoin` and `USD` contracts to the `CoreLoanPlatform` contract, allowing it to manage these tokens.
4. **Return Contracts**: Finally, it returns the deployed contracts for further use.

Now let’s install all the dependencies and compile our contract using the following:

```solidity
npm install
npx hardhat compile
```

Let’s deploy our contract using hardhat ignition just like last time:

```solidity
npx hardhat ignition deploy ./ignition/modules/Deploy.js --network core_testnet
```

Copy the addresses of DAPP, USD, and BTC Contract addresses from the terminal and paste them against the corresponding variables in the `.env` file present inside the `*./interface/`* folder*.*

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXdURE2z3XAZ2VYJf9zsyB1ZozHMKO98wFyQNNe_CcXiQjYbY0juwJkUNY1q1dpeDTg15HYDvRLL5OHXkLPRbc2PJk-m2NyC8ZJixRI-vcr5_9Q7uJbTKMUAV1VScqni3nw_cqDuL1HFCqUuaxpWrbgTSNgq?key=SvvLSoKwwYsKbkLRxbp6Ww)

Navigate to the react app and install the dependencies :

```solidity
cd interface
npm install
```

Copy the .json files containing the ABI from `*./artifacts/contracts*` to `*./interface/src/ABI/*` folder. You'll need to copy the following .json files from their respective folders

- Bitcoin.json
- CoreLoanPlatform.json
- IERC20.json
- USD.json

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXf62lahWLuvI5fC6dMnmg7ZnC2XeNDn4XRUJNJ5KRN-FtVWvimhXsaEUIy2tTnPsecnLdG3_hVfMgLuRlCggETGxgO0vLm4ka-I0PPQhn5Z0O6Ceg7N3XfdJx4aQ2C13AQWK5M8LNl3OyKQHjONaCwG4rbT?key=SvvLSoKwwYsKbkLRxbp6Ww)

Finally, let’s launch the frontend using:

```solidity
npm  start
```

## Frontend Interaction

Let’s interact with our code. Follow the steps given below:

1. Connect your wallet by clicking on “Connect Wallet”.
![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXfyJpL0MwxF7ahpB4vtOcZL7r7762R9gTBbOa-uSBzhaMnkQNsUTUpzDVSa_BvHQymOpoC-7ld_9QZ61RqaMD4XhU-12rhL1OSjwLvn0WHZ_YQ5iyj0YSDTIf15BCawfijx5b4MDTko0B6yan0zVDxGnNSL?key=SvvLSoKwwYsKbkLRxbp6Ww)

2. Next, fetch some tokens. Click on the faucet icon and accept the two prompts to receive tokens in your wallet.
![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXfOXOU8jBbjriYD45GwlYVO3dHWLzsiGJJLa0-VWheixxriNPpX5lYuBIhm3-NRyRC6B59SFC3tAF4YPMiRCv4Ez4W-AFszR1GP8ZJfD9z2ISyCeqVwGpBEZbkm4xzvpoCGkjvLbiRsnn3mypx_DSwOfo4?key=SvvLSoKwwYsKbkLRxbp6Ww)

3. It’s time to stake.
    - Enter 10 or any value you want in the tab under “Stake or Withdraw Collateral”.
    - Click on the Stake button.
    - Click on Next, Approve, and then Confirm.
  ![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXf-nZolnU7EedW7ajzaBN_NMKXODjVvxzlUfbT0nQGzKtYXrluHR6uHqBBB7JcTHmDC2-MX_o72Yck62R9Pt5o6ZoeDJ5quFUn7-kCGBHrAFzT7jJAueVf6-LIWpJRVdCiW4bV1yg5HH0k22t0GI1tv2AHb?key=SvvLSoKwwYsKbkLRxbp6Ww)

4. After a few seconds, you can see the updated values:
![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXeHGSj2oJw55ISuMqHQwO83fg0r1vWqviifEMAxdMR3IaPK0AhSKuquILQ3gDN3r0t41IHjbtFmDpmMohxuDAHM2HBpAhu8L03hq3HKCN4bfeezYEpxYs5AoC-Z10O19CSA9A0Vc78vmYK7ppH03K_vckw?key=SvvLSoKwwYsKbkLRxbp6Ww)

5. And now it’s time to test our withdrawal functionality.
    - Enter 6 or any value you want in the tab under “Stake or Withdraw Collateral”
    - Click on the Withdraw button
    - Click on Confirm
![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXe6pRn1pWGjQzYSXb5B7P_r7c90uLBBmy_MTJNISOkfGgxtD2SDrFAuvjoiAdzRKAMJDVoCsN72c-hPC_414umu5S4807xBkRpdQvbKkcm3Gt3nyFMLifKoVrLni3xS2TwpdsYxJYeLxeRaflBUSQn-BmEk?key=SvvLSoKwwYsKbkLRxbp6Ww)

6. After a few seconds, you can see the updated values:
![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXdDV79SxcexhZisxHpd65XtWarUz1U7LD-5_eQ4aXOyJ08cOuqlFXk0BgmtOuQ-3cGau69qguOrK-ZukJfMYrdNI66Rvr7_Qb2qVaKWWT81axeR63_GPrKO145rOd5eTNoSp7SFDGw97eEj60-0Yat_qr4Y?key=SvvLSoKwwYsKbkLRxbp6Ww)

7. Try BTC staking too, but for now, it doesn’t work because we haven’t implemented lending functionality.
![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXfIVs0D1JZR21uLMuKViWbr3DPi9IxEmVv7ZqOoe9DALn9fPT-fRZmgMhvHy-yyhERUC1IlSxkvi1QxZR0SiWfmfET9mjRapaKGkcJeH8AbQRXNEGZPVXlU05SyJlsoNV4KVOhbBVUuZvYSbMTEqr6PPF8P?key=SvvLSoKwwYsKbkLRxbp6Ww)

And that’s it, our app now allows users to stake and withdraw whenever they wish. Onto the last step!

## Pushing it to Git

Make sure you are in `build-lending-dapp-on-core` folder.

And as always, remember to push your code to your GitHub repository using the following commands.

```solidity
git add .
git commit -m "code update"
git push
```

## That’s a wrap

We covered understanding constructors for initializing contracts, setting token addresses, and using arithmetic and relational operators along with the required statement. It included practical applications by implementing and explaining the deposit and withdrawal functions, followed by compiling and deploying the smart contract on the Core testnet.

In the next lesson, we will implement more functionalities. Stay tuned!