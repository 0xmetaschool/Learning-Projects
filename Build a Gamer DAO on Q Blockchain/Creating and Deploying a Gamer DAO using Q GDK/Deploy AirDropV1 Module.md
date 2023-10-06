# Deploy AirDropV1 Module

Awesome folks! So you created a complex module to do AirDrops. Now it’s time to deploy it! In this lesson, we will create a Merkle tree by providing the wallet addresses, the whitelist addresses. The main task of this deploy file will be to deploy the AirDropV1 module and create the Merkle tree that will be used for Merkle Proof in the next lesson.

## Let’s start coding

Navigate to `scripts/AirDropV1/2_deploy_airdropV1.js` and start writing the following code:

### Add necessary modules

The following lines import necessary modules for the script to work with.

```
const { ethers } = require("hardhat");
Web3 = require('web3');
const keccak256 = require("keccak256");
const { MerkleTree } = require("merkletreejs");
const fs = require("fs");
```

- `ethers` is used to interact with the Ethereum blockchain and smart contracts using Hardhat.
- `Web3` is used to work with the Ethereum or other EVM based networks (like Q blockchain).
- `keccak256` is used for hashing data using the keccak256 algorithm.
- `MerkleTree` is used to create a Merkle tree for the airdrop verification.
- `fs` is used to read and write files.

### Main function

The script defines an asynchronous function named `main`.

```
async function main() {
	// Rest of the code goes here
}
```

- The `async` keyword indicates that the function contains asynchronous operations that will return Promises.  We used Promises because sometimes our function does not immediately return a result. For example, sometimes, we have to wait for the blockchain we are interacting with to confirm a transaction.

Now, we will add the code to our `main` function.

### Add contants

The following lines set the `qrc20Address` variables to the address of the QRC20 token contract you deployed. 

```
const qrc20Address = "<ADD_QRC20_CONTRACT_ADDRESS>"
const QRC20 = await ethers.getContractFactory("QRC20");
const contract = QRC20.attach(qrc20Address);
```

- Replace `"<ADD_QRC20_CONTRACT_ADDRESS>"` with your QRC20 token contract address. The one you also used for creating the DAO. You must have saved it `.env` file.
- `ethers.getContractFactory("QRC20")` fetches the factory of the `QRC20` contract from the compiled artifacts using the `ethers` library.
- `QRC20.attach(qrc20Address)` attaches the contract factory to the existing QRC20 token contract at the specified address.

### Creating Merkle tree

The following lines create a Merkle tree for a list of addresses used for airdrop verification.

```
// Merkle Root
let addresses = [
  {
      addr: "<YOUR-PUBLIC-WALLET-ADDRESS>",
  },
  {
      addr: "<YOUR-FRIEND-PUBLIC-WALLET-ADDRESS>"
  },
];

const leafNodes = addresses.map((address) =>
  keccak256(
     Buffer.from(address.addr.replace("0x", ""), "hex"),
  )
);

const merkleTree = new MerkleTree(leafNodes, keccak256, { sortPairs: true });
root = merkleTree.getHexRoot();

const data = {
  addresses: addresses.map((address) => address.addr),
  leafNodes: leafNodes,
  root: root,
};

fs.writeFileSync("tree.json", JSON.stringify(data, null, 2));

```

- `addresses` is an array of objects, each containing public wallet addresses. These are the addresses we will use for whitelisting. You can add your wallet address here along with any other address you want to add. You can also use just one address here.
- `leafNodes` is an array of hashed addresses using the keccak256 algorithm.
- A Merkle tree is created using the `MerkleTree` constructor, passing in `leafNodes` and the keccak256 function for hashing, with `sortPairs: true` to ensure pairs are sorted before hashing.
- The Merkle root of the tree is obtained using `merkleTree.getHexRoot()`.
- The data related to the Merkle tree is stored in a `data` object and written to a JSON file named `tree.json`.

### Deploying `AirdropV1` contract

The following lines deploy an `AirdropV1` contract and fund it with QRC20 tokens.

```
	console.log("Deploying Airdrop V1...");
	
	const AirDropV1 = await ethers.getContractFactory("AirDropV1");
	const dropAmt = Web3.utils.toWei('20', 'ether')
	const airdrop = await AirDropV1.deploy();
	await airdrop.waitForDeployment();
	console.log("AirdropV1 deployed to:", await airdrop.getAddress());
	
	await airdrop.create_airdrop(qrc20Address, dropAmt, root);
	
	console.log("Funding the Airdrop");
```

- `AirdropV1` contract factory is obtained using `ethers.getContractFactory("AirDropV1")`.
- The contract is deployed using `airdrop = await AirDropV1.deploy()`.
- `airdrop.waitForDeployment()` waits for the deployment process to complete.
- The address of the deployed AirdropV1 contract is obtained using `airdrop.getAddress()`.
- The AirDrop is created by calling the `create_airdrop` function on the Airdrop contract with the specified parameters `qrc20Address`, `dropAmt`, and `root`.

### Mint tokens

Remember we didn’t mint our in previous lessons? This block of code just do that. It mints QRC20 token to your AirDrop contract.

```
	// mint token
	const airdropAddress = airdrop.getAddress();
	const mintAmount = Web3.utils.toWei('2000', 'ether');
	await contract.mintTo(airdropAddress, mintAmount);
	console.log("Airdrop Funded...");
```

- In, `mintAmount` variable we are basically storing the amount of tokens we want to mint. Here, we are storing `2000` in `mintAmount` constant. You can also set up the amount of tokens you want to mint.
- `contract.mintTo(airdropAddress, mintAmount)` finally mint the QRC20 token to the AirDrop contract address.

Here, our `main` function ends. 

### Call `main` function

Lastly, outside of the `main` function, we will call `main()` to run the script.

```
main();
```

## Complete code

Here’s how the complete code looks like. Remember to add this in `2_deploy_airdropV1.js` file.

```
const { ethers } = require("hardhat");
Web3 = require('web3');
const keccak256 = require("keccak256");
const { MerkleTree } = require("merkletreejs");
const fs = require("fs");

async function main() {
    
	  const qrc20Address = "<YOUR-QRC20-TOKEN-ADDRESS>"
    const QRC20 = await ethers.getContractFactory("QRC20");
    const contract = QRC20.attach(qrc20Address);

    // Merkle Root
    let addresses = [
      {
          addr: "<YOUR-PUBLIC-WALLET-ADDRESS>",
      },
      {
          addr: "<YOUR-FRIEND-PUBLIC-WALLET-ADDRESS>"
      
      },
      ];
  
      const leafNodes = addresses.map((address) =>
      keccak256(
         Buffer.from(address.addr.replace("0x", ""), "hex"),
      
      )
      );
  
      const merkleTree = new MerkleTree(leafNodes, keccak256, { sortPairs: true });

      root = merkleTree.getHexRoot();

      const data = {
        addresses: addresses.map((address) => address.addr),
        leafNodes: leafNodes,
        root: root,
      };

      fs.writeFileSync("tree.json", JSON.stringify(data, null, 2));
    

      console.log("Deploying Airdrop V1...");

      const AirDropV1 = await ethers.getContractFactory("AirDropV1");
      

      const dropAmt = Web3.utils.toWei('20', 'ether')
      const airdrop = await AirDropV1.deploy();

      await airdrop.waitForDeployment();

      console.log("AirdropV1 deployed to:", await airdrop.getAddress())
      await airdrop.create_airdrop(qrc20Address,dropAmt,root)

      console.log("Funding the Airdrop");

      //mint token
      const airdropAddress = airdrop.getAddress();
      const mintAmount = Web3.utils.toWei('2000', 'ether');
      await contract.mintTo(airdropAddress, mintAmount);
      console.log("Airdrop Funded...");
  } 

  main();
```

**Note:** Don’t forget to update `<YOUR-QRC20-TOKEN-ADDRESS>`, `<YOUR-PUBLIC-WALLET-ADDRESS>`, and `<YOUR-FRIEND-PUBLIC-WALLET-ADDRESS>` with your addresses.

## Let’s run the script

After updating the addresses, run the following command to run the `2_deploy_airdropV1.js` script file.

```
npx hardhat run scripts/AirDropV1/2_deploy_airdropV1.js --network testnet
```

This command will give you the output like this:

![Frame 3560339 (3).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/6.%20Deploy%20AirDropV1%20Module/Frame_3560339_(3).webp)

Now, head over to your Q DAO Factory Dashboard. You will notice that your DAO is now filled with 2k Meta tokens.

![Frame 3560339 (4) (1).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/6.%20Deploy%20AirDropV1%20Module/Frame_3560339_(4)_(1).webp)

## That’s a wrap

In summary, this script deploys an `AirdropV1` contract and funds it with QRC20 tokens by minting them to the Airdrop contract address. Before creating the Airdrop, it generates a Merkle tree of addresses to be used for airdrop verification and stores the relevant data in a JSON file. The script utilizes `ethers` and `Web3` libraries for contract deployment and interaction, and `keccak256` and `MerkleTree` for Merkle tree generation.