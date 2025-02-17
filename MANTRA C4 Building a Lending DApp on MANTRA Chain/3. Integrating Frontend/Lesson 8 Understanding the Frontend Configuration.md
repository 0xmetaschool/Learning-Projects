# Understanding the Frontend Configuration

Awesome job buddy! We are done with the backend code. Now it’s time to see how it looks on the frontend side. Let’s start implementing and understanding it. Excited? Let’s go!

## Frontend Folder

Make sure you are in the `build-lending-dApp-on-mantra/Lending` folder and run the following commands:

```
cd interface
npm install --legacy-peer-deps
```

## Frontend Configuration

First things first, let's take a peek at our blockchain configuration. Navigate to `interface/src/chain.js`. This file is the blueprint for our dApp's connection to the MANTRA Dukong Testnet. Let's break it down and see what we've got:

```jsx
export const mantraChainConfig = {
  chainId: "mantra-dukong-1",
  chainName: "MANTRA Dukong Testnet",
  rpc: "https://rpc.dukong.mantrachain.io",
  rest: "https://api.dukong.mantrachain.io",
// ... (more configuration details)
};

export const CONTRACT_ADDRESS = import.meta.env.VITE_CONTRACT_ADDRESS;
export const USD_TOKEN_ADDRESS = import.meta.env.VITE_USD_TOKEN_ADDRESS;
export const OM_TOKEN_ADDRESS = import.meta.env.VITE_OM_TOKEN_ADDRESS;
```

### MANTRA Dukong Testnet: Your Playground

Think of this configuration as your dApp's ID card for the MANTRA Dukong Testnet. Here's what each part does:

- **Chain ID & Name**: The network is identified by `"chainId": "mantra-dukong-1"`, and it's known as the **MANTRA Dukong Testnet**.
- **RPC & REST Endpoints**:
    - **RPC**: `https://rpc.dukong.mantrachain.io`
    - **REST API**: `https://api.dukong.mantrachain.io`

These endpoints are essential for interacting with the blockchain, submitting transactions, and querying data.

### Address Configuration

The chain configuration includes detailed address prefixing through the `bech32Config`:

```jsx
bech32Config: {
  bech32PrefixAccAddr: "mantra",
  bech32PrefixAccPub: "mantrapub",
  bech32PrefixValAddr: "mantravaloper",
  bech32PrefixValPub: "mantravaloperpub",
  bech32PrefixConsAddr: "mantravalcons",
  bech32PrefixConsPub: "mantravalconspub",
}
```

This ensures all addresses on the network follow the correct formatting and prefixing conventions.

### Money Matters

Our testnet has its own currency system:

```jsx
currencies: [
  {
    coinDenom: "OM",
    coinMinimalDenom: "uom",
    coinDecimals: 6,
    coinGeckoId: "mantra-chain"
  }
]
```

Here, we're dealing with "OM" tokens. The "uom" is the minimal denomination, with each OM being divisible into a million "uom" units (hence the 6 decimals).

### Paying the Toll: Transaction Fees

Transactions on the blockchain require fees:

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
      high: 0.03
    }
  }
]
```

This sets up different fee tiers for transactions:

- Low priority: 0.01 OM per unit of gas
- Average priority: 0.025 OM per unit of gas
- High priority: 0.03 OM per unit of gas

### Staking Currency and Features

```jsx
stakeCurrency: {
  coinDenom: "OM",
  coinMinimalDenom: "uom",
  coinDecimals: 6,
  coinGeckoId: "mantra-chain"
}
features: ["cosmwasm"]
```

- OM is used for both transactions and network staking
- The network supports CosmWasm for smart contract execution

### Environment Variables: Contract Addresses

```jsx
export const CONTRACT_ADDRESS = import.meta.env.VITE_CONTRACT_ADDRESS;
export const USD_TOKEN_ADDRESS = import.meta.env.VITE_USD_TOKEN_ADDRESS;
export const OM_TOKEN_ADDRESS = import.meta.env.VITE_OM_TOKEN_ADDRESS;
```

Our contract addresses are now managed through environment variables:

1. Create a `.env` file in your project root
2. Add your contract addresses:

```bash
VITE_CONTRACT_ADDRESS=your_contract_address
VITE_USD_TOKEN_ADDRESS=your_usd_token_address
VITE_OM_TOKEN_ADDRESS=your_om_token_address
```

This approach provides better security and flexibility for managing contract addresses across different environments.

## That's a Wrap!

Great job! You've just decoded the DNA of our dApp's connection to the blockchain. This configuration is crucial - it's the roadmap our dApp uses to navigate the MANTRA Dukong Testnet.