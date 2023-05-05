require("hardhat-deploy");
require("dotenv").config();
require("hardhat-gas-reporter");
require("@nomiclabs/hardhat-ethers");
require("hardhat-deploy-ethers");
require("@nomiclabs/hardhat-etherscan");

const PRIVATE_KEY = process.env.PRIVATE_KEY;
const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL;
const MUMBAI_RPC_URL = process.env.MUMBAI_RPC_URL;

module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 31337,
    },
    mumbai: {
      url: MUMBAI_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 80001,
      blockConfirmations: 3,
    },
    goerli: {
      url: GOERLI_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 5,
      blockConfirmations: 6,
    },
    mainnet: {
      url: process.env.MAINNET_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 1,
      blockConfirmations: 6,
    },
  },
  etherscan: {
    apiKey: "7VBN6JTPVRUUZ87TCPQXXKRKX2MG2ATBTM",
  },

  solidity: {
    compilers: [
      {
        version: "0.6.12",
      },
      {
        version: "0.4.17",
      },
      { version: "0.8.8" },
    ],
  },

  namedAccounts: {
    deployer: {
      default: 0,
    },
  },
};
