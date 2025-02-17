# Building the Frontend - 1

Awesome job buddy! We are done with the backend code. Now it’s time to see how it looks on the frontend side. Let’s start implementing and understanding it. Excited? Let’s go!

## Frontend Folder

Make sure you are in the `build-fine-art-tokenization-dApp-on-mantra` folder and run the following commands:

```
cd interface
npm install --legacy-peer-deps
```

## Setting Up Your Contract Address

Navigate to the `interface/src/chain.js`. This file contains the configuration details for the **MANTRA Dukong Testnet**. Here's a breakdown of the key elements:

```
export const mantraChainConfig = {
  chainId: "mantra-dukong-1",
  chainName: "MANTRA Dukong Testnet",
  rpc: "https://rpc.dukong.mantrachain.io",
  rest: "https://api.dukong.mantrachain.io",
  bip44: {
    coinType: 118,
  },
  bech32Config: {
    bech32PrefixAccAddr: "mantra",
    bech32PrefixAccPub: "mantrapub",
    bech32PrefixValAddr: "mantravaloper",
    bech32PrefixValPub: "mantravaloperpub",
    bech32PrefixConsAddr: "mantravalcons",
    bech32PrefixConsPub: "mantravalconspub",
  },
  currencies: [
    {
      coinDenom: "OM",
      coinMinimalDenom: "uom",
      coinDecimals: 6,
      coinGeckoId: "mantra-chain",
    },
  ],
  feeCurrencies: [
    {
      coinDenom: "OM",
      coinMinimalDenom: "uom",
      coinDecimals: 6,
      coinGeckoId: "mantra-chain",
      gasPriceStep: {
        low: 0.01,
        average: 0.025,
        high: 0.03,
      },
    },
  ],
  stakeCurrency: {
    coinDenom: "OM",
    coinMinimalDenom: "uom",
    coinDecimals: 6,
    coinGeckoId: "mantra-chain",
  },
  features: ["cosmwasm"],
};

export const CONTRACT_ADDRESS = import.meta.env.VITE_CONTRACT_ADDRESS;
```

### MANTRA Dukong Testnet Configuration

- **Chain ID & Name**: The network is identified by `"chainId": "mantra-dukong-1"`, and it's known as the **MANTRA Dukong Testnet**.
- **Network Endpoints**:
    - **RPC**: `https://rpc.dukong.mantrachain.io`
    - **REST API**: `https://api.dukong.mantrachain.io` These endpoints are essential for interacting with the blockchain, submitting transactions, and querying data.

### **Bech32 Configuration**

```jsx
  bech32Config: {
    bech32PrefixAccAddr: "mantra",
    bech32PrefixAccPub: "mantrapub",
    bech32PrefixValAddr: "mantravaloper",
    bech32PrefixValPub: "mantravaloperpub",
    bech32PrefixConsAddr: "mantravalcons",
    bech32PrefixConsPub: "mantravalconspub",
  },
```

The **Bech32** addresses for different actors on the blockchain (accounts, validators, etc.) follow this pattern:

- **Account Address**: `mantra`
- **Account Public Key**: `mantrapub`
- **Validator Operator Address**: `mantravaloper`
- **Validator Operator Public Key**: `mantravaloperpub`
- **Consensus Node Address**: `mantravalcons`
- **Consensus Node Public Key**: `mantravalconspub`

### **Currencies**

```jsx
 currencies: [
    {
      coinDenom: "OM",
      coinMinimalDenom: "uom",
      coinDecimals: 6,
      coinGeckoId: "mantra-chain",
    },
  ],
```

The network uses **OM** as its primary currency:

- **Token Symbol**: `OM`
- **Base Denomination**: `uom` (micro-OM, the smallest unit)
- **Decimals**: 6 (meaning 1 OM = 1,000,000 uom)
- **CoinGecko ID**: `mantra-chain`

### **Fee Structure**

```jsx
  feeCurrencies: [
    {
      coinDenom: "OM",
      coinMinimalDenom: "uom",
      coinDecimals: 6,
      coinGeckoId: "mantra-chain",
      gasPriceStep: {
        low: 0.01,
        average: 0.025,
        high: 0.03,
      },
    },
  ],
```

Transaction fees are also paid in **OM** with three gas price tiers:

- **Low**: 0.01 OM
- **Average**: 0.025 OM
- **High**: 0.03 OM

### Staking Currency and Features

```jsx
  stakeCurrency: {
    coinDenom: "OM",
    coinMinimalDenom: "uom",
    coinDecimals: 6,
    coinGeckoId: "mantra-chain",
  },
  features: ["cosmwasm"],
};
```

- **OM** is also used for staking:
    - **Denomination**: `"OM"`
    - **Minimal Denomination**: `"uom"`
    - **Decimals**: 6
- The network supports **CosmWasm**, allowing for smart contracts to be executed on the blockchain.

### **Contract Address**

The contract address is loaded from environment variables:

To set up your contract address:

1. Create a `.env` file in your project root
2. Add your contract address:

```
VITE_CONTRACT_ADDRESS=your_contract_address_here
```

Make sure to replace `your_contract_address_here` with your actual deployed contract address.

## That’s a wrap

Great job in completing the setup that is essential for connecting a wallet, running a dApp, or interacting with the MANTRA Dukong Testnet blockchain! For the next steps, stay tuned!