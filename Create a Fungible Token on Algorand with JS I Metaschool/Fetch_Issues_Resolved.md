# `Deployments to createAsset.js continuously reverted with a `fetch error`

## `Here is the full error related to the provided course code`

```sh
ReferenceError: fetch is not defined
    at URLTokenBaseHTTPClient.get (/home/jaz/Documents/ACADEMICS/WEB3.0/TOKEN-ALGORAND/token/node_modules/algosdk/dist/cjs/client/urlTokenBaseHTTPClient.js:112:21)
    at HTTPClient.get (/home/jaz/Documents/ACADEMICS/WEB3.0/TOKEN-ALGORAND/token/node_modules/algosdk/dist/cjs/client/client.js:183:39)
    at SuggestedParamsRequest.do (/home/jaz/Documents/ACADEMICS/WEB3.0/TOKEN-ALGORAND/token/node_modules/algosdk/dist/cjs/client/v2/jsonrequest.js:49:34)
    at deployToken (/home/jaz/Documents/ACADEMICS/WEB3.0/TOKEN-ALGORAND/token/CreateAsset.js:26:67)
    at Object.<anonymous> (/home/jaz/Documents/ACADEMICS/WEB3.0/TOKEN-ALGORAND/token/CreateAsset.js:67:1)
    at Module._compile (node:internal/modules/cjs/loader:1196:14)
    at Object.Module._extensions..js (node:internal/modules/cjs/loader:1250:10)
    at Module.load (node:internal/modules/cjs/loader:1074:32)
    at Function.Module._load (node:internal/modules/cjs/loader:909:12)
    at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:81:12)

```

**I solved that issue with the below fixations where i opted to utilize dynamically the `node-fetch` 
and enabled the patch global fetch to be used by Algorand after analysing the issue wisely**

```sh
// Dynamic import for node-fetch
const fetch = (...args) => import('node-fetch').then(({ default: fetch }) => fetch(...args));

// Patch global fetch to be used by Algorand SDK
global.fetch = fetch;
```

## `And here goes the complete code for `CreateAsset.js` file`

```sh
const algosdk = require("algosdk");
const fs = require("fs");

// Dynamic import for node-fetch
const fetch = (...args) => import('node-fetch').then(({ default: fetch }) => fetch(...args));

// Patch global fetch to be used by Algorand SDK
global.fetch = fetch;

const token = "";
const server = "https://testnet-api.algonode.cloud";
const port = 443;

const client = new algosdk.Algodv2(token, server, port);

// deploy token
const deployToken = async () => {
    // Read the account details from JSON
    const accountData = JSON.parse(fs.readFileSync('account.json', 'utf-8'));
    const { address, privateKey } = accountData;

    // Convert the private key from base64 string back to Uint8Array
    const privateKeyUint8 = new Uint8Array(Buffer.from(privateKey, "base64"));

    // Get suggested transaction parameters
    const suggestedParams = await client.getTransactionParams().do();

    // Create an asset creation transaction
    console.log("Creating token Metadata....");
    const txn = algosdk.makeAssetCreateTxnWithSuggestedParamsFromObject({
        from: address,
        suggestedParams,
        defaultFrozen: false,
        unitName: "Jaz", // symbol
        assetName: "Jaz coin", // name of the asset
        manager: address,
        reserve: address,
        freeze: address,
        clawback: address,
        total: 1000,
        decimals: 0, // decimals
    });

    // Sign the transaction
    const signedTxn = algosdk.signTransaction(txn, privateKeyUint8);

    // Submit the transaction to the network
    await client.sendRawTransaction(signedTxn.blob).do();

    // Wait for confirmation
    const result = await algosdk.waitForConfirmation(client, txn.txID().toString(), 3);

    console.log("Token deployed successfully!!");

    const assetIndex = result['asset-index'];

    console.log(`Asset ID created: ${assetIndex}`);

    // Display AlgoExplorer URL
    const url = `https://testnet.explorer.perawallet.app/asset/${assetIndex}`;
    console.log(`Asset Url: ${url}`);

    // End the console
    process.exit();
};

deployToken().catch(console.error);
```

### **The above is a an issue I faced on my end and managed to fix it - so if the logic is just broken at this point of time, this is a clear way of fixing it!!**

WAGMI

**Jonas Sebera**

-------------------------------------
 @0xJonaseb11
