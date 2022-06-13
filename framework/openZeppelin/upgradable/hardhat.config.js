/**
 * @type import('hardhat/config').HardhatUserConfig
 */

require('@nomiclabs/hardhat-ethers')
require('@openzeppelin/hardhat-upgrades')
require('ethers')

module.exports = {
  
  solidity: {
    version: "0.8.3"
  },
};