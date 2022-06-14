const { hre, ethers, upgrades } = require("hardhat");

async function main() {
  // await hre.ether => fix ethers
  const Box = await ethers.getContractFactory("Box");
  const box = await upgrades.deployProxy(Box, [42], {
    initializer: "initialize",
  });

  await box.deployed();

  console.log("box deployed to:", box.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
