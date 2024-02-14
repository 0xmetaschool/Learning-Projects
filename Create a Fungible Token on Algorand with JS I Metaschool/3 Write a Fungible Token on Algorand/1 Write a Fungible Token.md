# Write a Fungible Token

Hey buddy, welcome back! You've done an awesome job making it this far in the course. Till now, you've learned about Algorand and set up the development environment.

Now, you’re just going to dive right into the project.

## Writing code for fungible token

Create a file named `CreateAsset.js` in the root folder and let’s start writing the code.

```jsx
const algosdk = require('algosdk');
const fs = require('fs');
```

- The code imports the required modules: `algosdk` for interacting with the Algorand blockchain and `fs` for file system operations.

```jsx
const token = '';
const server = 'https://testnet-api.algonode.cloud';
const port = 443;

const client = new algosdk.Algodv2(token, server, port);
```

- The code sets up the connection to the Algorand Testnet using the `token`, `server`, and `port`.
- `const client = new algosdk.Algodv2(token, server, port);`: This line creates a new connection to the Algorand network using the previously set token, server, and port number.

```jsx
async function deployToken() {
```

- The `deployToken` function is declared. It will handle the process of deploying a new token on the Algorand blockchain.

```jsx
  const accountData = JSON.parse(fs.readFileSync('account.json', 'utf8'));
  const { address, privateKey } = accountData;
```

- The code reads the account details from a JSON file named `account.json` created in the last lesson, which should contain the address and private key of the Algorand account to be used for token deployment.
- The `address` and `privateKey` variables are extracted from the `accountData` object.

```jsx
  const privateKeyUint8 = new Uint8Array(Buffer.from(privateKey, 'base64'));
```

- The private key, which was stored in `base64` format, is converted back to a `Uint8Array` so it can be used for signing transactions.

```jsx
  const suggestedParams = await client.getTransactionParams().do();
```

- `const suggestedParams = await client.getTransactionParams().do();`: This line fetches the transaction parameters from the Algorand network. These parameters will be used to create a new asset/fungible token.
- An instance of `algosdk.Algodv2` is created to interact with the Algorand node.

```jsx
  console.log("Creating the Token Metadata");
  const txn = algosdk.makeAssetCreateTxnWithSuggestedParamsFromObject({
    from: address,
    suggestedParams,
    defaultFrozen: false,
    unitName: 'Pepe', // Symbol
    assetName: 'Pepe Coin', // Name of the asset
    manager: address,
    reserve: address,
    freeze: address,
    clawback: address,
    total: 1000,
    decimals: 0, // Decimals
  });
```

- The code creates a new asset creation transaction using `algosdk.makeAssetCreateTxnWithSuggestedParamsFromObject()`.
- The `from` field specifies the sender's Algorand address (`address` variable) that will be the creator of the token.
- The `suggestedParams` contains the suggested transaction parameters previously fetched from the Algorand node.
- The `defaultFrozen` field is set to `false`, meaning the token is not frozen by default.
- The `unitName` is set to `'Pepe'`, which represents the symbol of the token.
- The `assetName` is set to `'Pepe Coin'`, which represents the name of the asset.
- The `manager`, `reserve`, `freeze`, and `clawback` fields are set to the sender's address (`address` variable) for simplicity in this example, meaning the sender will control all aspects of the token.
- The `total` field is set to `1000`, which represents the total number of tokens to be created.
- The `decimals` field is set to `0`, meaning the token does not support decimal places (i.e., it is a whole number token).

The `txn` variable now holds the asset creation transaction, ready to be signed and submitted to the Algorand network to create the new token.

```jsx
  const signedTxn = algosdk.signTransaction(txn, privateKeyUint8);
```

- The transaction is signed using the private key converted to `Uint8Array`.

```jsx
  await algodClient.sendRawTransaction(signedTxn.blob).do();
```

- The signed transaction is submitted to the Algorand network for processing.

```jsx
  const result = await algosdk.waitForConfirmation(algodClient, txn.txID().toString(), 3);

```

- The code waits for the transaction to be confirmed on the blockchain using `algosdk.waitForConfirmation()`.

```jsx
  console.log("Token deployed");
  const assetIndex = result['asset-index'];
  console.log(`Asset ID created: ${assetIndex}`);
```

- A success message is displayed, indicating that the token deployment was successful.
- The asset index of the newly created token is retrieved from the `result` object and printed to the console.

```jsx
  const url = `https://testnet.explorer.perawallet.app/asset/${assetIndex}`;
  console.log(`Asset URL: ${url}`);
```

- The testnet URL for the newly created asset is constructed and printed to the console.

```jsx
  process.exit();
}
```

- The script ends after the token deployment process is completed.

```jsx
deployToken().catch(console.error);
```

- The `deployToken` function is called to initiate the token deployment process.

## Complete code

Here is the complete code of `CreateAsset.js` for you:

```jsx
const algosdk = require('algosdk');
const fs = require('fs');

const token = '';
const server = 'https://testnet-api.algonode.cloud';
const port = 443;

const client = new algosdk.Algodv2(token, server, port);

async function deployToken() {
  // Read the account details from JSON
  const accountData = JSON.parse(fs.readFileSync('account.json', 'utf8'));
  const { address, privateKey } = accountData;

  // Convert the private key from base64 string back to Uint8Array
  const privateKeyUint8 = new Uint8Array(Buffer.from(privateKey, 'base64'));

  // Get suggested transaction parameters
  const suggestedParams = await client.getTransactionParams().do();

  // Create an asset creation transaction
  console.log("Creating the Token Metadata");
  const txn = algosdk.makeAssetCreateTxnWithSuggestedParamsFromObject({
    from: address,
    suggestedParams,
    defaultFrozen: false,
    unitName: 'Pepe', // Symbol
    assetName: 'Pepe Coin', // Name of the asset
    manager: address,
    reserve: address,
    freeze: address,
    clawback: address,
    total: 1000,
    decimals: 0, // Decimals
  });

  // Sign the transaction
  const signedTxn = algosdk.signTransaction(txn, privateKeyUint8);

  // Submit the transaction to the network
  await client.sendRawTransaction(signedTxn.blob).do();

  // Wait for confirmation
  const result = await algosdk.waitForConfirmation(client, txn.txID().toString(), 3);
  
  console.log("Token deployed");
  const assetIndex = result['asset-index'];
  console.log(`Asset ID created: ${assetIndex}`);

  // Display AlgoExplorer URL
  const url = `https://testnet.explorer.perawallet.app/asset/${assetIndex}`;
  console.log(`Asset URL: ${url}`);

  // End the console
  process.exit();
}

deployToken().catch(console.error);
```

## That’s a wrap

That's it! The code creates a new asset with specific properties, sends the asset creation transaction to the Algorand network, waits for confirmation, and then displays the asset's details to the user. Well, that was a lot but you were great at understanding this much information!

In the next lesson, we’ll deploy and interact with our created token! Don’t forget to submit your assignments otherwise, I will be sad :(