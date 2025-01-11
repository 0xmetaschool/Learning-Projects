# Setup Environment

Welcome back!  So, you've completed learning about Algorand? Awesome! In this lesson, you're going to learn how to set up the dev environment to run your code. We will create a new wallet and fund the wallet using JS code. 

## Set up env

- Open a terminal on your machine or utilize an IDE like Visual Studio.
- Create a directory using the command: `mkdir <folder name>`. Replace `<folder name>` with your preferred name of the folder.
- Go to the created directory using the command: `cd <folder name>`.
- Now run the following commands:
    
    ```
    npm init --yes
    npm install algosdk
    npm list algosdk
    ```
    
- Create a new file named `CreateAccount.js` in the root of your directory. I’ll explain what this file does in the later section of this lesson, so don’t worry! For now just follow the steps and all of this will become clear soon 💪🏼
- Paste the following code to the file:
    
    ```
    const algosdk = require('algosdk');
    const fs = require('fs');
    
    // Function to wait for user input
    function keypress() {
      return new Promise((resolve) => {
        process.stdin.once('data', () => {
          resolve();
        });
      });
    }
    
    async function createAccountAndExport() {
      // Create an account
      const generatedAccount = algosdk.generateAccount();
      const passphrase = algosdk.secretKeyToMnemonic(generatedAccount.sk);
      console.log(`My address: ${generatedAccount.addr}`);
      console.log(`My passphrase: ${passphrase}`);
      const dispenser_url = `https://dispenser.testnet.aws.algodev.network/?account=${generatedAccount.addr}`;
      console.log(`Fund the wallet via Algorand Dispenser: ${dispenser_url}`);
      console.log("Press any key when the account is funded");
      await keypress();
    
      // Convert the private key to base64 string
      const privateKeyBase64 = Buffer.from(generatedAccount.sk).toString('base64');
    
      // Export the account details as JSON
      const accountData = {
        address: generatedAccount.addr,
        passphrase: passphrase,
        privateKey: privateKeyBase64,
      };
      fs.writeFileSync('account.json', JSON.stringify(accountData, null, 2));
    
      console.log("Account details exported to account.json");
    
      process.exit();
    }
    
    createAccountAndExport();
    ```
    
    Here’s how my file in Visual Studio looks like:
    
    ![Frame 3560364 (14).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests-for-algorand/2_1%20Setup%20Environment/Frame_3560364_(14).webp?raw=true)
    
- Now run the following command in the terminal:  `node CreateAccount.js`. It will show output like this:
    
    ![Frame 3560365 (1).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests-for-algorand/2_1%20Setup%20Environment/Frame_3560365_(1).webp?raw=true)
    
    - It shows your account address, your mnemonic recovery 25-word phrase or passphrase (don’t share it with anyone!), and a link to the dispenser to fund your wallet. ***Copy the passphrase and save it somewhere, we will need it in the next lesson.***
    - Click on the Algorand Dispenser link.
    - Select the reCAPTCHA and click on Dispense.
    - 5 ALGOs will be dispatched to your wallet.
    
    ![Frame 48095929 (3).jpg](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests-for-algorand/2_1%20Setup%20Environment/Frame_48095929_(3).webp?raw=true)
    
- Now click “Enter” or any key in the terminal where you ran the `node CreateAccount.js` command.
    - **Don’t worry!** We will explain how to verify if our wallet is filled with ALGOs in the next lesson.

## Code explanation

Let’s understand what we did in the `CreateAccount.js` file:

```jsx
const algosdk = require('algosdk');
const fs = require('fs');
```

- The code imports the required modules: `algosdk` for interacting with the Algorand blockchain and `fs` for file system operations.

```jsx
function keypress() {
  return new Promise((resolve) => {
    process.stdin.once('data', () => {
      resolve();
    });
  });
}
```

- We created this function to wait for the user until they fund the wallet.
    - `function keypress() { ... }`: This is a function named `keypress` that doesn't take any inputs (arguments). It returns a `Promise`, which is like a promise to do something in the future.
    - `return new Promise((resolve) => { ... });`: This line creates a new `Promise`. A `**Promise`** in JavaScript is a way to handle operations that don't complete instantly, like waiting for user input. The Promise has a `**resolve`** function, which, when called, signals that the Promise has successfully completed its task.
    - `process.stdin.once('data', () => { resolve(); });`: The `.once('data', ...)` means we're waiting for a one-time event where the user provides some input (e.g., pressing a key). Once this input is detected, the `resolve` function of the `Promise` is called, indicating that the waiting period is over and the `Promise` is fulfilled.

```jsx
async function createAccountAndExport() {
  const generatedAccount = algosdk.generateAccount();
  const passphrase = algosdk.secretKeyToMnemonic(generatedAccount.sk);
  console.log(`My address: ${generatedAccount.addr}`);
  console.log(`My passphrase: ${passphrase}`);
  const dispenser_url = `https://dispenser.testnet.aws.algodev.network/?account=${generatedAccount.addr}`;
  console.log(`Fund the wallet via Algorand Dispenser: ${dispenser_url}`);
  console.log("Press any key when the account is funded");
  await keypress();
```

- The `createAccountAndExport` function is declared. It generates a new Algorand account and extracts the address and passphrase from it. It is marked as `async`, which means it can use `await` inside it to wait for asynchronous actions.
- `const generatedAccount = algosdk.generateAccount();`: This line creates a new Algorand account (like a digital wallet) and stores it in the variable `generatedAccount`.
- `const passphrase = algosdk.secretKeyToMnemonic(generatedAccount.sk);`: This line converts the secret key of the account into a human-readable passphrase (a set of words) and stores it in the variable `passphrase`.
- `console.log(My address: ${generatedAccount.addr});`: This line prints the address of the newly created account to the console.
- `console.log(My passphrase: ${passphrase});`: This line prints the passphrase to the console.
- `const dispenser_url = ...`: This line creates a URL for an Algorand dispenser (a service that gives free testnet tokens). It includes the address of the account so it can be funded.
- `console.log(Fund the wallet via Algorand Dispenser: ${dispenser_url});`: This line prints the dispenser URL to the console, telling the user to fund their account by visiting that link.
- `console.log("Press any key when the account is funded");`: This line prints a message to the console, asking the user to press any key once they have funded their account.
- `await keypress();`: This line waits for the user to press any key. The program will pause here until the user presses a key.
- The function prompts the user to press any key when the account is funded, using the previously defined `keypress` function, and `await` to wait for the keypress.

```jsx
  const privateKeyBase64 = Buffer.from(generatedAccount.sk).toString('base64');
```

- The private key of the generated account is converted to a `base64` string representation.

```jsx
  const accountData = {
    address: generatedAccount.addr,
    passphrase: passphrase,
    privateKey: privateKeyBase64,
  };
  fs.writeFileSync('account.json', JSON.stringify(accountData, null, 2));

```

- The account details, including the address, passphrase, and private key, are stored in an object called `accountData`.
- The `accountData` object is written to a JSON file named `account.json`, with an indentation of 2 spaces for better readability.
- Storing the account data is essential as we will need while creating a fungible token.

```jsx
  console.log("Account details exported to account.json");
```

- A message is displayed in the console to indicate that the account details have been successfully exported to the JSON file.

```jsx
  process.exit();
}
```

- The script exits after all the necessary operations are completed.

```jsx
createAccountAndExport();
```

- The `createAccountAndExport` function is called to start the account creation and export process.

## That’s a wrap

So, folks, we have successfully created our account and funded it too. In the next lesson, we will import our wallet. Remember to copy your passphrase, we will need it! Stay tuned!