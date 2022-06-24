const { hre, ethers, upgrades } = require("hardhat");

const proxyAddress = "0xDB910436B2EB3CA24e14d72eb0DD2275BA87EFFA";

async function main() {
  const UUPSver2 = await ethers.getContractFactory(
    "ERC20UpgradeableWithUUPSver2"
  );

  const uupsVer2 = await upgrades.upgradeProxy(proxyAddress, UUPSver2);

  await uupsVer2.deployed();

  console.log("uups ERC20 upgraded:", uupsVer2.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
