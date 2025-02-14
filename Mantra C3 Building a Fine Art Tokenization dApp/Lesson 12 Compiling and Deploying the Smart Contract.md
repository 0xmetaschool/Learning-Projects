# Compiling and Deploying the Smart Contract

Hey there devs, we are finally done with our Smart contract and inn this lesson, we'll walk through the process of compiling our smart contract and deploying it to the MANTRA Chain testnet. This is an exciting step as it brings our Fine Art Tokenization dApp to life on the blockchain!

## Step 1: Set Up the Environment

First, ensure you have the correct environment variables set:

```bash
source mantrachaind-cli.env
```

## Step 2: Compile the Contract

Compile the contract for WebAssembly:

```bash
cargo build --target wasm32-unknown-unknown --release
```

## Step 3: Optimize the WASM Binary

Use the CosmWasm optimizer to reduce the size of the WASM binary:

```bash
docker run --rm -v "$(pwd)":/code \
  --mount type=volume,source="$(basename "$(pwd)")_cache",target=/target \
  --mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
  cosmwasm/optimizer:0.16.0
```

## Step 4: Store the Contract on the Blockchain

Run the following command to upload your optimized wasm binary to the network and store the response in the `RES` variable. This response will contain the unique Code ID of your uploaded binary.

Note : If you have funded the wallet named under ‘wallet2’ then do specify “wallet2” instead of “wallet” in the following commands. 

```bash
RES=$(mantrachaind tx wasm store artifacts/art_tokenization_mantra_chain.wasm --from wallet $TXFLAG -y --output json)
echo "Store response: $RES"
```

## Step 5: Retrieve the Code ID

Let’s use the `RES` variable to request the transaction hash, stored as `TX_HASH`. With this hash, you can then fetch the full transaction details, including events, and extract the `CODE_ID` from the response.

```bash
TX_HASH=$(echo $RES | jq -r .txhash)
CODE_ID=$(mantrachaind query tx $TX_HASH $NODE -o json | jq -r '.events[] | select(.type == "store_code") | .attributes[] | select(.key == "code_id") | .value')
echo "Code ID: $CODE_ID"
```

## Step 6: Verify the Contract Code

List contracts associated with the Code ID:

```bash
mantrachaind query wasm list-contract-by-code $CODE_ID $NODE --output json
```

Download and compare the stored WASM binary:

```bash
mantrachaind query wasm code $CODE_ID $NODE download.wasm
diff artifacts/art_tokenization_mantra_chain.wasm download.wasm
```

## Step 7: Instantiate the Contract

To instantiate our smart contract, we'll follow these steps to ensure proper setup and verification. Make sure you have the `CODE_ID` from the previous deployment step. Incase you’ve funded wallet2 then do replace `wallet` with `wallet2`  in the following set of commands. 

### 1. Get Wallet Address

First, let's fetch your wallet address:

```bash
WALLET_ADDR=$(mantrachaind keys show wallet -a)
echo "Wallet address: $WALLET_ADDR"
```

### 2. Instantiate the Contract

Now we'll instantiate the contract using your wallet address as the owner:

```jsx
INIT_TX=$(mantrachaind tx wasm instantiate $CODE_ID '{"name":"ArtToken", "symbol":"ART", "minter":"'$WALLET_ADDR'", "max_mints": 1000, "mint_price": {"denom": "uom", "amount": "20000"}}' \
--from wallet2 \
--label "art_tokenization_mantra_chain" \
--no-admin \
$TXFLAG \
--output json -y)
echo "Instantiate response: $INIT_TX"
```

### 3. Get Transaction Hash

Fetch the transaction hash for verification:

```bash
INIT_TX_HASH=$(echo $INIT_TX | jq -r .txhash)
echo "Instantiate tx hash: $INIT_TX_HASH"
```

## Step 8: Retrieve the Contract Address

Finally, retrieve and verify the contract address:

```bash
CONTRACT_ADDR=$(mantrachaind query tx $INIT_TX_HASH $NODE --output json | jq -r '.events[] | select(.type == "instantiate").attributes[] | select(.key == "_contract_address").value')
echo "Contract address: $CONTRACT_ADDR"
```

## Step 9: Verify Contract State

Query the contract's information and state:

```bash
mantrachaind query wasm contract $CONTRACT $NODE
mantrachaind query wasm contract-state all $CONTRACT $NODE
```

## Important: Save the Contract Address

Make sure to copy and save the contract address output from Step 8. You will need this address when integrating with the frontend of your dApp.

```bash
echo "Contract address: $CONTRACT_ADDR"
```

Wrap Up

Congratulations! You've successfully compiled and deployed your Fine Art Tokenization smart contract to the MANTRA Chain testnet. The contract is now live and ready to interact with. In the next lesson, we'll start integrating our front end with the backend.

Remember to keep your contract address safe, as you'll need it for all future interactions with your smart contract!