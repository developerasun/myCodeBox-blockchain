const { ethers, upgrades } = require("hardhat")

const ProxyAddress = "0x5e451eAbb038879dE59D7D9b6c1dc873262A0816"

async function main() {
  // await hre.ether => fix ethers
  const JakeV2 = await ethers.getContractFactory("JakeV2")

  // upgrades.upgradeProxy: proxy address, version 2 contract
  const jakeV2 = await upgrades.upgradeProxy(ProxyAddress, JakeV2)
  console.log("jake nft updated to ver2")
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
