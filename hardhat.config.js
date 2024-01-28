/**
 * @type import('hardhat/config').HardhatUserConfig
 */

require("dotenv").config();
require("@nomiclabs/hardhat-ethers");

const { API_URL, PRIVATE_KEY} = process.env;

module.exports = {
  solidity: "0.8.11",
  defaultNetwork: "cosvm",
  networks: {
    hardhat: {},
    cosvm: {
      // Replace these placeholder values with the actual configurations for cosvm
      url: API_URL, // Replace with the actual RPC URL for cosvm
      accounts: [PRIVATE_KEY], // Replace with the account(s) for cosvm

      gas: 8, // Replace with the desired gas limit for transactions on cosvm
      gasPrice: 8, // Replace with the desired gas price for transactions on cosvm
    },
  },
};
