const { ethers, upgrades } = require("hardhat");

const ProxyAddress = "0x5F8C412BCBF0E8357A3C6Aed51214854a1cFA0D3";

async function main() {
  // await hre.ether => fix ethers
  const BoxV2 = await ethers.getContractFactory("BoxV2");

  // upgrades.upgradeProxy: proxy address, version 2 contract
  const boxV2 = await upgrades.upgradeProxy(ProxyAddress, BoxV2);
  console.log("box updated");
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
