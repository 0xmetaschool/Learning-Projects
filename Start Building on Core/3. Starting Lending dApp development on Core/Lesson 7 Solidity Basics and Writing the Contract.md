# Solidity Basics and Writing the Contract Skeleton

Welcome back, people! It's time to take our first steps to create our smart contract for the lending dApp so that we can later set it free on the Core blockchain. Just like how you’ll need a keyboard to code, we need Solidity to communicate with the Core blockchain.

Now if you’re already familiar with Solidity then writing the contract is gonna be a breeze, if you aren’t familiar with Solidity then we got you, comrade 💪. We’ll quickly brief you on the basics of Solidity then we can go ahead to create our smart contract for the lending dApp and then deploy it to the testnet. So let’s kick off with the basics!

## The Solid Basics

Alright, let’s start with the basics. Head over to the `contracts` folder that will contain an empty file named `CoreLoanPlatform.sol`. This is the file where all the magic will happen.

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXcM7PILhX4HFyJSbaoGAlQOfc69PkUrGbcUi9l6wf9mUyifxjS_f9c_wYj7z5dAVQP6Bq3r69x1dwE_UW3_rFz3jyyniQrCNQU4RENbox230Z4bZgCgwerGy6-lx7sFoGfqNwU1riR19wvNN4Brz3CXluk?key=4LaIVa-wPwo9LlwevICM7A)

Let’s start with a bare-bones contract containing only the following three things:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract CoreLoanPlatform {

}
```

- **License Identifier** The comment `SPDX-License-Identifier: MIT` is there to indicate that our code uses the MIT license. It’s kind of like putting a label on your work so everyone knows they can use it freely. This is important for open-source projects to clarify the licensing and usage rights.
- **pragma keyword** The `pragma` keyword is used to specify the version of Solidity that our code should be compiled with. Here, `pragma solidity ^0.8.24`; means we want our contract to work with Solidity version `0.8.24` or any newer version. This helps prevent compatibility issues with different compiler versions.
- **An empty contract named `CoreLoanPlatform`**
    
    This is where our contract starts taking shape. Right now, it's just an empty shell, but soon we'll be adding components and all the logic that will make our lending dApp work. Think of it as a blank canvas we will paint upon later.
    

## Contract Components

A typical Contract in Solidity will contain three things:

1. **State Variables**
2. **Functions**
3. **Events**

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXfuAfMrv8-wHQj_yL7kDb-Ibzpgsx5JVcofmD7ydepTj5f1aeY4QpW9-C8oibn9EUPIBxLmMlREekENm1tKnC3cOkKIB3cSAjaO8LE6p-9mByJvpyM-Ya9wDYmmhDCVJli1nK8K7WulvI9RTucg9RaZe9Ri?key=4LaIVa-wPwo9LlwevICM7A)

Let's start with understanding state variables and how to create them.

### State Variables

State variables in Solidity act as the vault for storing data on the blockchain. They persist throughout the contract's lifespan, residing within the contract itself but outside specific functions. In our lending dApp, these variables hold crucial details such as :

- Collateral ratio
- Interest rate
- Loan duration

We’ll create them as public state variables that can be accessed and modified by internal function calls in the contract. The syntax is simple: datatype followed by variable name. You can even assign the variable a value while declaring it as well.

```solidity
// <data-type> <variable-name> = <value>;
uint myVariable = 123;
```

Now that we are talking about data types, let’s address them a bit.

### Data Types

Solidity has value types (such as Integer or Boolean, which store actual data) and reference types (like addresses, which store pointers to data locations). Let’s focus on value types for now, we’ll go over reference types in the next lesson.

- **Signed/Unsigned Integers**: Integer data types store whole numbers, with signed integers storing both positive and negative values (`int`) and unsigned integers storing non-negative values (`uint`).
- **Booleans**: The Boolean data type is declared with the `bool` keyword and can hold only two possible constant values: `true` or `false`.
- **Addresses**: The `address` type is used to store a wallet or smart contract addresses, typically 20 bytes in size.
- **Byte Arrays**: Byte arrays, declared with the keyword `bytes`, are fixed-size arrays used to store a predefined number of bytes up to 32.
- **Enums**: Enums, short for Enumerable, are a user-defined data type that restricts the value of the variable to a particular set of constants defined within the program.

To store the collateral ratio, interest rate, and loan duration, we will use the `uint256` type and as these values are not to be changed then we’ll make them fixed using the `constant` keyword.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract CoreLoanPlatform {
	uint256 public constant COLLATERAL_RATIO = 150; // 150% collateralization
	uint256 public constant INTEREST_RATE = 5; // 5% interest rate
	uint256 public constant LOAN_DURATION = 30 days;
}
```

Let’s also create two more `uint256` variables to store the total amount of staked BTC and the total amount of borrowed BTC as follows.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract CoreLoanPlatform {
	uint256 public constant COLLATERAL_RATIO = 150; // 150% collateralization
	uint256 public constant BORROWABLE_RATIO = 80; // 80% of collateral can be borrowed
	uint256 public constant INTEREST_RATE = 5; // 5% interest rate
	uint256 public constant LOAN_DURATION = 30 days;
	uint256 private totalStaked = 0; //Counter for total staked
	uint256 private totalBorrowed = 0; //Counter for total borrowed
}
```

Remember, we can use these variables inside of functions by following the same syntax, but they’ll be a local variable that can only be used within the function or block (the area between the curly braces.)

Let’s deploy this contract onto the testnet and see how it’d look. First, navigate to `./ignition/modules` folder and then update the contents of `deploy.js` to the following:

```solidity
const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");
module.exports = buildModule("LoanDAppBasicModule", (m) => {
	const Contract = m.contract("CoreLoanPlatform", []);
	return { Contract };
});
```

Now, compile the contract using the following command:

```solidity
npx hardhat compile
```

Finally, let’s deploy our contract by running the following command in your terminal:

```solidity
npx hardhat ignition deploy ./ignition/modules/deploy.js --network core_testnet
```

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXcO9h4Hr2rgc_2T8Hau26Lwy9Akcn_9fNImen0tQ9h6ka-UqSrWYUoRv54rSDAg7g84DMREBBXdOu26G-prHhhqve84wm7PvYdoqybafCNO38q118cauHkG9RFRPdKWjr9dzOZJ3pMDqQ49oI9YYq5jthSA?key=4LaIVa-wPwo9LlwevICM7A)

This will deploy the CoreLoanPlatform contract to the Core testnet, and you'll receive a console message showing the deployment address of your contract. Copy the address and head over to [Core TestNet Scan](https://scan.test.btcs.network/). Paste the address in the search panel and you should be able to see your contract live in the Core blockchain.

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXdHUMFfZR1zk2BfSPiihElLyMbLPwRqN_ffsK9XAUICZk3AZn-ZYXnDHg1TKfzogfCDwhDe7OzMAKciTWTpPrnr8vJMLN8Ryy8T6PAKjbvPrDV9s6AVdDrJDIf22RT1nhtSiRPrTuN06O5cMmGIVtqt1HE?key=4LaIVa-wPwo9LlwevICM7A)

## Contract Verification

Transparency and Trust are two of the cornerstones of blockchain technology. Our deployed contract currently needs to be verified. We’ll be guiding you through how you can verify your contract using the Core Explorer. Verifying our contract will make it so that users can trust its functionality, see exactly how it works, and ensure it hasn't been tampered with, enhancing the overall credibility and security of our platform. Follow the steps given below to verify your own contract.

**Note**: To align your smart contract with Core [Chain's guidelines](https://docs.coredao.org/docs/Dev-Guide/smart-contract-guidelines), ensure that the "evmVersion" parameter is set to "Paris" under the solidity compiler settings in hardhat.config

- Select the contract tab and click on *Verify and publish* hyperlink.
- Fill in the needed details on the verification page, like:
    - Contract address: This field will be pre-filled.
    - Compiler type: We will be selecting "Single File" under Compiler type as our current contract is quite simple to begin with. In case if you end up creating complex contracts in the future, such as contracts with external imports, You’ll go with the Standard Json compiler type.
    - Compiler version: Select it as v0.8.24+
    - Open-source license type: License type of our contract will be *MIT License*.
- Click on the Continue button so as to proceed.

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXejskj6DmUDFypXLo1XtUiC2h0f7JnZv18kxm90H7RgGXz8Q61Q66pahsP14d0wZ0PEl2hpQ2du0hqpFgPhdc8LyiyRvWNJKqb5a-1anBGZrnnCMBojdQecHmOqlkvhzeFNdwFYJMHDtZS0MJ2-WNlPjlBk?key=4LaIVa-wPwo9LlwevICM7A)

- Select *Yes* under the Optimization field.
- Enter your Smart contract code in the provided field.
- As we have not created any custom constructor for our contract yet, we can leave the Constructor Argument Field empty.
- Click on the *Verify and Publish* button to finish the process.

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXfKFkgCvJ21Tka3jmB_UeYMivnSrUjAZtUUuOXGv0V5-haz43ZK5-qfdktnyuRh_7yH5G4Nw3cCemed0ApFZ_qA93zdih6gxOcFB2EI387bb6m5akhDUxD-wwMEDllWBgxv_CJQSC1tx1Ebjb873M1jYx8?key=4LaIVa-wPwo9LlwevICM7A)

There we go, we have successfully verified our contract and your contract should be shown below in the Explorer.

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXf420B547ASkWqpC_1xZPaQRf6Q90p8dout4mNPBwzDlWbTmfHtEEE8t6y5SPkLnh901hc7EK4SJOIDfGID-VYHn0rTqaqKy8rv0AcdN8NPqJB--FdTzowXAs1NWBPswNroWy-5zxh8fIljqgQv4X1dK0rE?key=4LaIVa-wPwo9LlwevICM7A)

## That’s a Wrap

In this lesson, we began building our smart contract for the lending dApp on the Core blockchain. Starting with Solidity basics, we defined key variables like collateral ratios and interest rates. We also saw the process to verify our contract on the Core Network. Next, we’ll focus on implementing storage solutions for loans and enhancing our dApp’s functionality. So, we’ll see you in the next lesson✌️.