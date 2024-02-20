# Write Deploy Scripts

Welcome!! So finally we are done with the code, so can move on to deploying it. But first, we need to write the deploy scripts. So let’s go, Wohoo!

## Deploy script for Token.sol

Navigate to `scripts/deployToken.js` and paste the following code to it: 

```jsx
const { ethers } = require("hardhat");
const fs = require("fs");

async function main() {

  const [deployer] = await ethers.getSigners();
  const name = "Meta";
  const symbol = "META";
  const maxSupply = ethers.parseEther("50");
  const publicPrice = ethers.parseEther("0"); 
  const initialtokenSupply = ethers.parseEther("0"); 
  const signer = deployer.address 

  const argumentsArray = [name, symbol, maxSupply.toString(), publicPrice.toString(), initialtokenSupply.toString(), signer]
  const content = "module.exports = " + JSON.stringify(argumentsArray, null, 2) + ";";
  fs.writeFileSync("./arguments.js", content);

  console.log("arguments.js file generated successfully.");

  console.log("Deploying contracts with the account:", deployer.address);

  const Token = await ethers.getContractFactory("NFTMintDN404");
  const token = await Token.deploy(
    name,
    symbol,
    maxSupply,
    publicPrice,
    initialtokenSupply,
    signer,
  );

  console.log("Fractionalized NFT deployed to:", await token.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
```

### Code explanation

```jsx
const { ethers } = require("hardhat");
const fs = require("fs");
```

- The script imports the required **`ethers`** package from Hardhat for interacting with Ethereum contracts and the **`fs`** (file system) module for file operations.

```jsx
async function main() {
```

- Defines an asynchronous function named **`main()`** to execute the deployment process.

```jsx
  const [deployer] = await ethers.getSigners();
```

- Retrieves the deployer's Ethereum account (the first account) using **`getSigners()`**.

```jsx
  const name = "Meta";
  const symbol = "META";
  const maxSupply = ethers.parseEther("50");
  const publicPrice = ethers.parseEther("0");
  const initialtokenSupply = ethers.parseEther("0");
  const signer = deployer.address;
```

- Defines various parameters required for deploying the contract, such as **`name`**, **`symbol`**, **`maxSupply`**, **`publicPrice`**, **`initialtokenSupply`**, and **`signer`**.

```jsx
  const argumentsArray = [name, symbol, maxSupply.toString(), publicPrice.toString(), initialtokenSupply.toString(), signer];
```

- Creates an array **`argumentsArray`** containing the deployment arguments.

```jsx
  const content = "module.exports = " + JSON.stringify(argumentsArray, null, 2) + ";";
```

- Converts **`argumentsArray`** into a JSON string with proper formatting and assigns it to the **`content`** variable.

```jsx
  fs.writeFileSync("./arguments.js", content);
```

- Writes the JSON string to a file named **`arguments.js`**.

```jsx
  console.log("arguments.js file generated successfully.");
```

- Logs a success message indicating that the **`arguments.js`** file has been generated.

```jsx
  console.log("Deploying contracts with the account:", deployer.address);
```

- Logs the Ethereum address of the deployer's account.

```jsx
  const Token = await ethers.getContractFactory("NFTMintDN404");
```

- Retrieves the contract factory for the **`NFTMintDN404`** contract.

```jsx
  const token = await Token.deploy(
    name,
    symbol,
    maxSupply,
    publicPrice,
    initialtokenSupply,
    signer,
  );
```

- Deploys the **`NFTMintDN404`** contract with the specified parameters.

```jsx
  console.log("Fractionalized NFT deployed to:", await token.getAddress());}
```

- Logs the Ethereum address where the contract has been deployed.

```jsx
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
```

- Invokes the **`main()`** function to start the deployment process.
- If the deployment is successful, it exits the process with code 0; otherwise, it logs any error encountered and exits the process with code 1.

## Deploy script for NFTMarketplace.sol

Navigate to `scripts/deployMarketplace.js` and paste the following code to it: 

```jsx
const { ethers } = require("hardhat"); 

async function main() {

  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const NFTMarketplace = await ethers.getContractFactory("NFTMarketplace");
  const marketplace = await NFTMarketplace.deploy();

  console.log("NFT Marketplace deployed to:", await marketplace.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
```

### Code explanation

- `const { ethers } = require("hardhat");`: The script imports the required **`ethers`** package from Hardhat for interacting with Ethereum contracts.
- `async function main() {`: Defines an asynchronous function named **`main()`** to execute the deployment process.
- `const [deployer] = await ethers.getSigners();`: Retrieves the deployer's Ethereum account (the first account) using **`getSigners()`**.
- `console.log("Deploying contracts with the account:", deployer.address);`: Logs the Ethereum address of the deployer's account.
- `const NFTMarketplace = await ethers.getContractFactory("NFTMarketplace");`: Retrieves the contract factory for the **`NFTMarketplace`** contract.
- `const marketplace = await NFTMarketplace.deploy();`: Deploys the **`NFTMarketplace`** contract.
- `console.log("NFT Marketplace deployed to:", await marketplace.getAddress());`: Logs the Ethereum address where the contract has been deployed.

```jsx
main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
```

- Invokes the **`main()`** function to start the deployment process.
- If the deployment is successful, it exits the process with code 0; otherwise, it logs any error encountered and exits the process with code 1.

## Wrap Up

In conclusion, this lesson provided detailed steps on how to write deploy scripts for Ethereum contracts. We learned how to define parameters, retrieve the contract factory, and deploy the contract. We also saw how to handle potential deployment errors. 

In the next lesson, we will run these scripts to deploy the contracts. Stay tuned!