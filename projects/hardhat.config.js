require("ethereum-waffle");
require("@nomiclabs/hardhat-waffle");
require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-etherscan");
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: {
    version: "0.8.15",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1,
      },
      evmVersion: "london", // default value managed by solc
    },
  },
  networks: {
    ropsten: {
      url: process.env.INFURA_API_KEY,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API,
  },
};
