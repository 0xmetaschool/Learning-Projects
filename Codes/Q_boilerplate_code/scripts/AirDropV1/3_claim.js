const { ethers } = require("hardhat");
const keccak256 = require("keccak256");
const { MerkleTree } = require("merkletreejs");
web3 = require('web3');

const fs = require("fs");

async function main() {
  const Airdrop = "0x40f0121632F2cbB27Ff966af151639493161Ee93";
  const Airdrop_fac = await ethers.getContractFactory("AirDropV1");
  const contract = Airdrop_fac.attach(Airdrop);

  const accounts = await ethers.getSigners();
  const claimAddress = accounts[0].address; //Caller's address

  //Get the Merkle data from the json
  const jsonData = fs.readFileSync('tree.json', 'utf-8');
  const data = JSON.parse(jsonData);
  const leafNodes = data.leafNodes.map((node) => Buffer.from(node, 'hex'));
  const merkleTree = new MerkleTree(leafNodes, keccak256, { sortPairs: true });

  console.log("---------");
  console.log("Merkle Tree");
  console.log("---------");
  console.log(merkleTree.toString());

  // Get all proofs for the claimAddress
  const proofArray = leafNodes.map((node) =>
    merkleTree.getHexProof(node)
  );

  console.log("Claiming Airdrop");

  //Claiming the Aidrop to the caller's address after checking if the caller is whitelisted
  let isClaimed = false;

  for (let i = 0; i < proofArray.length; i++) {
    const isWhitelisted = await contract.isWhitelistedUser(claimAddress, proofArray[i]);

    if (isWhitelisted) {
      await contract.claimReward(claimAddress, proofArray[i]);
      console.log("Claimed Airdrop for address:", claimAddress);
      isClaimed = true;
      break;
    }
  }

  if (!isClaimed) {
    console.log("Not a whitelisted user.");
  }
}

main();
