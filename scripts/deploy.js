const hre = require("hardhat");




async function main() {
  const NFTMarketplace = await hre.ethers.getContractFactory("TwoFactorAuth");
    const nFTMarketplace = await NFTMarketplace.deploy();

    


// const NFTMarketplace = await hre.ethers.getContractFactory("MintSeaCollection");
// const nFTMarketplace = await NFTMarketplace.deploy();
  await nFTMarketplace.deployed();

  console.log("NFTMarketplace:", nFTMarketplace.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });





