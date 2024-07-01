require("@nomiclabs/hardhat-waffle");
require("dotenv").config({ path: ".env" });
require("@nomiclabs/hardhat-etherscan");

module.exports = {
  solidity: "0.8.0",

  // 2 For Sepolia Testnet///

  //For sepolia Testnet///
  networks: {
    sepolia: {
      url: "PUT here sepolia.infura.io URL or alcemy URL",
      accounts: [`Put here your metamask wallet Private key`], // this is 2nd profile address
      // gasPrice: 20000000000,
    },
  },

  // 1:Etherscan Explore

  etherscan: {
    apiKey: {
      sepolia: "Put Here Etherscan api key",
    },
  },
};
