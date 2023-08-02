require("@nomiclabs/hardhat-web3");
require("@nomiclabs/hardhat-truffle5");
require('crypto');
require('@openzeppelin/hardhat-upgrades');
require("@dlsl/hardhat-migrate");
require('web3')



const dotenv = require("dotenv");
dotenv.config();

function privateKey() {
  return process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [];
}

function typechainTarget() {
  const target = process.env.TYPECHAIN_TARGET;

  return target === "" || target === undefined ? "ethers-v5" : target;
}

function forceTypechain() {
  return process.env.TYPECHAIN_FORCE === "true";
}

module.exports = {
  networks: {
    hardhat: {
      initialDate: "1970-01-01T00:00:00Z",
      accounts: {
        accountsBalance: "1000000000000000000000000000000",
      },
      hardfork: "berlin",
    },
    testnet: {
      url: "https://rpc.qtestnet.org/",
      accounts: privateKey(),
    },
    mainnet: {
      url: "https://rpc.q.org",
      accounts: privateKey(),
    },
  },
  etherscan: {
    apiKey: {
      devnet: "abc",
      testnet: "abc",
      mainnet: "abc",

    },
  },
  solidity: {
    version: "0.8.19",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
      viaIR: false,
      evmVersion: "berlin",
    },
  },
  migrate: {
    pathToMigrations: "./scripts/",
  },
};