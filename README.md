# Decentralized Voting Application by Team - Easyians , Pragyan Hackathon 2024

This is a demo application to implement voting in solidity smart contract using ReactJS and CosVM

## Installation

Install the packages using

```shell
npm install
```

In deploy.js file, Make sure to feed the

1. Record of voters mapped to their respective wallet public keys
2. Record of candidates participating in the election so that the vote can be cast appropriately
3. Voting time

Compile the contract and upload it to the blockchain network. Run the following commands to compile and upload the contract.

To copy the contents of .env.example into a new file .env,

```shell
cp .env.example .env
```

And add the private key of your wallet here which offers gas fee as CVM for deploying the smart contract

```shell
npx hardhat compile
npx hardhat run --network cosvm scripts/deploy.js
```

Once the contract is uploaded to the blockchain, copy the contract address and copy it in the .env file. You can also use another blockchain by writing the blockchain's endpoint in hardhat-config.

**Steps before running the frontend**

- Paste the Private key in .env file
- Paste the contract address once depolyed in constant.js file

**Once setup, simply run the command :**

```shell
npm start
```
