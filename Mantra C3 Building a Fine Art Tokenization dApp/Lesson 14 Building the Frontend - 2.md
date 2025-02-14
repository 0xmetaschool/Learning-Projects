# Building the Frontend - 2

So glad to have you back! Now that we've set up the configuration, let's dive into the logic part of our NFT minting application.

In this section, we'll explore the core functionality that enables users to interact with our smart contract, view NFT details, and mint their own NFTs. We'll break down each component to understand how they work together to create a seamless minting experience.

The main logic resides in our custom React hook `useNftContract`, which serves as a bridge between our frontend application and the blockchain. This hook encapsulates all the necessary functions for interacting with our smart contract while providing proper error handling and loading states.

## Mint the NFT

Navigate to the `interface/src/hooks/useNFTContract.js`. This hook contains all the logic for interacting with our NFT contract. Let's break down each part of this implementation to understand how it all works together:

### Imports Section

First, we need to import all the necessary dependencies that will help us interact with the blockchain and manage our application state:

```jsx
import { useCallback, useState } from 'react';
import { useAccount, useCosmWasmClient } from "graz";
import { SigningCosmWasmClient } from "@cosmjs/cosmwasm-stargate";
import { CONTRACT_ADDRESS } from '../chain';
import { GasPrice } from "@cosmjs/stargate";
import { coins } from "@cosmjs/proto-signing";
```

These imports provide the foundation for our blockchain interactions:

- **useCallback** and **useState**: React hooks for managing state and memoizing functions to prevent unnecessary re-renders
- **useAccount** and **useCosmWasmClient**: Custom hooks from Graz that provide wallet connection and contract interaction capabilities
- **SigningCosmWasmClient**: A client that can sign and send transactions to CosmWasm smart contracts
- **CONTRACT_ADDRESS**: Your deployed NFT contract's address (loaded from environment variables)
- **GasPrice** and **coins**: Utilities for handling transaction fees and token amounts

### useNftContract Hook Initialization

The **`useNftContract`** hook starts by setting up the core states and connections we'll need:

```jsx
export function useNftContract() {
  const { data: account } = useAccount();
  const { data: cosmWasmClient } = useCosmWasmClient();
  const [loading, setLoading] = useState(false);
```

This initialization sets up our foundation:

- **account**: Contains the connected wallet's information (address, etc.)
- **cosmWasmClient**: A client for reading from the blockchain
- **loading**: State variable to track async operations

### getSigningClient Function

This function handles our secure connection to the blockchain:

```jsx
const getSigningClient = useCallback(async () => {
  if (!window.keplr) throw new Error("Keplr not found");
  await window.keplr.enable("mantra-dukong-1");
  const offlineSigner = window.keplr.getOfflineSigner("mantra-dukong-1");
  const gasPrice = GasPrice.fromString('0.01uom');
  return await SigningCosmWasmClient.connectWithSigner(
    "https://rpc.dukong.mantrachain.io", 
    offlineSigner, 
    { gasPrice }
  );
}, []);
```

This function sets up our connection to MANTRA Dukong testnet by:

- Verifying Keplr wallet installation
- Enabling the appropriate chain
- Setting up a signer with the correct gas configuration
- Creating a connection to the network

### instantiateContract Function

This function helps us deploy new instances of our NFT contract:

```jsx
const instantiateContract = useCallback(async (initMsg) => {
  if (!account) return;
  setLoading(true);
  try {
    const signingClient = await getSigningClient();
    return await signingClient.instantiate(
      account.bech32Address,
      initMsg.code_id,
      initMsg,
      "Instantiate NFT Contract",
      "auto"
    );
  } finally {
    setLoading(false);
  }
}, [account, getSigningClient]);
```

The `instantiateContract` initializes or deploys a new instance of the NFT contract.

- Uses the **account** to sign the transaction and **getSigningClient** to get the signing client.
- Calls `instantiate` to deploy the smart contract with the provided initialization message (**initMsg**).

### queryConfig Function

Here's where we fetch all the NFT information:

```jsx
const queryConfig = useCallback(async (caller = "default") => {
  if (!cosmWasmClient) return null;
  
  try {
    setLoading(true);
    console.log("Querying NFT details...");
    const nftdetails = await cosmWasmClient.queryContractSmart(CONTRACT_ADDRESS, { 
      nft_details: {} 
    });
    
    const totalminted = await cosmWasmClient.queryContractSmart(CONTRACT_ADDRESS, { 
      num_tokens: {} 
    });

    // Default metadata handling
    let metadata = {
      name: "Mona Lisa",
      description: "Painting of Mona Lisa by Leonardo da Vinci",
      image: "ipfs://QmcDZp9pparq6R5N9xP6v4dvQdy4ueYwhjF4mS2t3WPWtf",
      attributes: [
        {
          "trait_type": "Artist",
          "value": "Leonardo da Vinci"
        }
      ]
    };

    // Process IPFS URL
    let imageUrl = metadata.image;
    if (imageUrl.startsWith('ipfs://')) {
      imageUrl = `https://gateway.pinata.cloud/ipfs/${imageUrl.slice(7)}`;
    }

    // Construct NFT object
    const nft = {
      name: metadata.name,
      description: metadata.description,
      image: imageUrl,
      attributes: metadata.attributes || [],
      mint_price: (Number(nftdetails.mint_price.amount) / 1000000),
      max_mint: Number(nftdetails.max_mints),
      total_minted: Number(totalminted.count)
    };

    return nft;
  } catch (error) {
    console.error("Error querying NFT config:", error);
    throw error;
  } finally {
    if (caller !== "mintNFT") {
      setLoading(false);
    }
  }
}, [cosmWasmClient]);
```

- **queryConfig**: Queries the NFT contract to get its configuration details.
    - Uses **queryContractSmart** to retrieve the contract details such as **nft_details** and **num_tokens** (total NFTs minted).
    - Fetches metadata from the URI stored in the NFT details and constructs a response object containing name, description, image, and minting price.
    - If called by any function other than `mintNFT`, it stops the loading state.

### mintNft Function

The core function for minting new NFTs:

```jsx
const mintNft = useCallback(async () => {
  if (!account) return;
  
  try {
    setLoading(true);
    console.log("Starting mint process...");

    const signingClient = await getSigningClient();
    const nftDetails = await queryConfig("mintNFT");
    
    if (!nftDetails) {
      throw new Error("Failed to fetch NFT details");
    }

    if (nftDetails.total_minted >= nftDetails.max_mint) {
      throw new Error("Maximum mint limit reached");
    }

    const mintPrice = nftDetails.mint_price;
    const result = await signingClient.execute(
      account.bech32Address,
      CONTRACT_ADDRESS,
      { mint: { owner: account.bech32Address, extension: {} } },
      "auto",
      "",
      coins(mintPrice * 1000000, "uom")
    );

    return result;
  } catch (error) {
    console.error("Mint failed:", error);
    throw error;
  } finally {
    setLoading(false);
  }
}, [account, getSigningClient, queryConfig]);
```

- **mintNft**: Mints a new NFT by sending a transaction to the contract.
    - Queries the contract details using **queryConfig** to get the mint price.
    - Executes the minting function on the contract using the **SigningCosmWasmClient**.
    - Sends the required minting fee in **OM** tokens (`uom` is the smallest unit).

### Return Values

```jsx
return { instantiateContract, queryConfig, mintNft, loading, setLoading };
```

- Exposes the functions **instantiateContract**, **queryConfig**, and **mintNft** along with the loading state for external use.

## Running the frontend

Make sure you are in the `build-fine-art-tokenization-dApp-on-mantra` folder and run the following command:

```
npm run dev
```

Your app will be connected at [`http://127.0.0.1:5173/`](http://127.0.0.1:5173/).

## Interacting with the Frontend

Connect your wallet and mint the NFT.

![mantra-mint-final.gif](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/Mantra%20c3%20Building%20a%20Fine%20Art%20Tokenization%20dApp/Lesson%2014%20Building%20the%20Frontend%20-%202/mantra-mint-final.webp?raw=true)

And with this, we are done!!! Yayyyy!

## That’s a wrap

You were awesome!!! Yes, we have finally run our application and minted the NFT. In the next lesson, we will conclude the course.