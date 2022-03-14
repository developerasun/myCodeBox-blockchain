/**
 * @type import('hardhat/config').HardhatUserConfig
 */

require('@nomiclabs/hardhat-ethers')
require('@openzeppelin/hardhat-upgrades')
require('ethers')

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

module.exports = {
  
  solidity: {
    version: "0.8.3"
  },
};