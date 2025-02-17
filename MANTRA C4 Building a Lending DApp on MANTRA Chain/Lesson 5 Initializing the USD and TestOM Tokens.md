# Initializing the USD and TestOM Tokens

Great job so far! We are down with understanding the code. Now it’s time to see how we can run it. So let’s run it!

## Prerequisites

- Ensure your `.env` file is properly sourced in your terminal
- Make sure you have the token contract WASM file in your `artifacts` directory
- Your `wallet` should have sufficient funds for deployment

## Step 1: Get Your Wallet Address

First, let's get your wallet address which we'll use for token distribution:

```bash
# Fetch and store your wallet address
WALLET_ADDR=$(mantrachaind keys show wallet2 -a)
echo "Wallet address: $WALLET_ADDR"
```

## Step 2: Deploy USD Token

### 2.1 Store the Contract and fetch it’s Code ID

Upload the token contract to the blockchain:

```bash
# Upload the contract code
RES=$(mantrachaind tx wasm store artifacts/token.wasm --from wallet2 $TXFLAG -y --output json)
echo "Sore response: $RES"

sleep 10

# Extract transaction hash and get code ID
TX_HASH=$(echo $RES | jq -r .txhash)
CODE_ID=$(mantrachaind query tx $TX_HASH $NODE -o json | jq -r '.events[] | select(.type == "store_code") | .attributes[] | select(.key == "code_id") | .value')
echo "Code ID: $CODE_ID"
```

### 2.2 Verify Contract Upload

Check if the contract is properly stored:

```bash
# List contracts for the code ID
mantrachaind query wasm list-contract-by-code $CODE_ID $NODE --output json
```

### 2.3 Instantiate USD Token

Create a new instance of the USD token contract:

```bash
# Prepare instantiation message
USD_INIT='{
  "name": "US Dollar",
  "symbol": "USD",
  "decimals": 6,
  "initial_balances": [
    {
      "amount": "10000000000",
      "address": "'"$WALLET_ADDR"'"
    }
  ]
}'

# Instantiate the contract
INIT_TX=$(mantrachaind tx wasm instantiate $CODE_ID "$USD_INIT" \
--from wallet2 \
--label "lending_dapp" \
--no-admin \
$TXFLAG \
--output json -y)
echo "Instantiate response: $INIT_TX"
```

### 2.4 Get Contract Address

Retrieve the deployed contract's address:

```bash
# Extract and store contract address
USD_CONTRACT=$(mantrachaind query tx $(echo $INIT_TX | jq -r .txhash) $NODE --output json | jq -r '.events[] | select(.type == "instantiate").attributes[] | select(.key == "_contract_address").value')
echo "USD Token Contract address: $USD_CONTRACT"
```

## Step 3: Deploy TestOM Token

### 3.1 Store Contract (if needed)

If you're using the same contract code, you can skip this step and reuse the CODE_ID. Otherwise:

```bash
# Upload the contract code
RES=$(mantrachaind tx wasm store artifacts/token.wasm --from wallet2 $TXFLAG -y --output json)
echo "Store response: $RES"

sleep 10

# Get new code ID
TX_HASH=$(echo $RES | jq -r .txhash)
CODE_ID=$(mantrachaind query tx $TX_HASH $NODE -o json | jq -r '.events[] | select(.type == "store_code") | .attributes[] | select(.key == "code_id") | .value')
echo "Code ID: $CODE_ID"
```

### 3.2 Instantiate TestOM Token

Create a new instance of the TestOM token contract:

```bash
# Prepare instantiation message
TESTOM_INIT='{
  "name": "OM Token",
  "symbol": "TestOM",
  "decimals": 6,
  "initial_balances": [
    {
      "amount":"10000000000",
      "address": "'"$WALLET_ADDR"'"
    }
  ]
}'

# Instantiate the contract
INIT_TX=$(mantrachaind tx wasm instantiate $CODE_ID "$TESTOM_INIT" \
--from wallet2 \
--label "lending_dapp" \
--no-admin \
$TXFLAG \
--output json -y)
echo "Instantiate response: $INIT_TX"
```

### 3.3 Get TestOM Contract Address

```bash
# Extract and store contract address
TESTOM_CONTRACT=$(mantrachaind query tx $(echo $INIT_TX | jq -r .txhash) $NODE --output json | jq -r '.events[] | select(.type == "instantiate").attributes[] | select(.key == "_contract_address").value')
echo "TestOM Token Contract address: $TESTOM_CONTRACT"
```

## Save Contract Addresses

Save both contract addresses into a text file for future use:

```bash
echo "USD Token: $USD_CONTRACT"
echo "TestOM Token: $TESTOM_CONTRACT"
```

## That’s a Wrap

You've successfully deployed both token contracts! Each step was:

1. Store the contract code on chain
2. Get the code ID for instantiation
3. Verify the upload
4. Instantiate with specific parameters
5. Get and save the contract address

Keep both contract addresses safe - you'll need them for deploying the Lending dApp in the next lesson.