// require("@nomiclabs/hardhat-waffle");
require("@openzeppelin/hardhat-upgrades");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

// box contract deployed to: 0x5F8C412BCBF0E8357A3C6Aed51214854a1cFA0D3
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.14",
  networks: {
    ropsten: {
      url: process.env.INFURA_API_KEY,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: {
      ropsten: process.env.ETHERSCAN_API,
    },
  },
};
