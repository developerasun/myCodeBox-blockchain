const { hre, ethers, upgrades } = require("hardhat");

async function main() {
  const Jake = await ethers.getContractFactory("Jake");
  const jake = await upgrades.deployProxy(Jake, [99], {
    initializer: "initialize",
  });

  await jake.deployed();

  console.log("jake nft deployed to:", jake.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
