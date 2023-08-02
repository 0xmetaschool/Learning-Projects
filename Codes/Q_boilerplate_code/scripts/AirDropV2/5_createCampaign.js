const {ethers}  = require("hardhat");
const keccak256 = require("keccak256");
const { MerkleTree } = require("merkletreejs");
require('dotenv').config();
web3 = require('web3');
const fs = require("fs");
const { QRC_TOKEN, MODULE_NAME, VOTING_CONTRACT_ADDRESS } = process.env;

async function getCurrentBlockTime() {
    return (await web3.eth.getBlock(await web3.eth.getBlockNumber())).timestamp;
  }

async function main() {

    const accounts = await ethers.getSigners();
    const senderAddress = accounts[0].address;

    // Get the contract factories for GeneralDAOVoting
    const GeneralDAOVotingFactory = await ethers.getContractFactory("GeneralDAOVoting");
    const VotingContract = GeneralDAOVotingFactory.attach(VOTING_CONTRACT_ADDRESS);

    // Merkle Root; Chnage the address accordingly, make sure there are at least two
    let addresses = [
        {
            addr: "0xABe215Fb79fB827978C82379d5974831E2FB5E0d",
        },
        {
            addr: "0xf503808EE7d381e14B5C39C4D28947D842fD7730"
        
        },
        ];
    
        const leafNodes = addresses.map((address) =>
        keccak256(
           Buffer.from(address.addr.replace("0x", ""), "hex"),
        
        )
        );
    
    const merkleTree = new MerkleTree(leafNodes, keccak256, { sortPairs: true });
    //Exporting the tree as JSON
    const data = {
        addresses: addresses.map((address) => address.addr),
        leafNodes: leafNodes,
        root: merkleTree.getHexRoot(),
      };

      fs.writeFileSync("tree.json", JSON.stringify(data, null, 2));

    //Airdrop Metadata
    const timeNow = await web3.eth.getBlock(await web3.eth.getBlockNumber()).timestamp;
    const cs = {
            rewardToken: QRC_TOKEN,
            rewardAmount: web3.utils.toWei('100', 'ether'),
            merkleRoot: merkleTree.getHexRoot(),
            // Make sure that startTimestamp is after the voting for creating a campaign is ended!
            startTimestamp: web3.utils.toBN(await getCurrentBlockTime()).add(500).toString(),
            endTimestamp: web3.utils.toBN(await getCurrentBlockTime()).add(2000).toString(),
    };

    const abi = require("../../artifacts/contracts/AirDropV2.sol/AirDropV2.json");

    const contractInterface = new ethers.utils.Interface(abi);
        
    const createCampaignCalldata = contractInterface.encodeFunctionData("createCampaign", [
            cs.rewardToken,
            cs.rewardAmount,
            cs.merkleRoot,
            cs.startTimestamp,
            cs.endTimestamp,
    ]);
 
    console.log("Creating Campaign Proposal");
    await VotingContract.createProposal(`${MODULE_NAME}`, `Create campaign with ${MODULE_NAME}`, createCampaignCalldata,{        
        from: senderAddress,
    });

    console.log("Proposal Created");
}

main();