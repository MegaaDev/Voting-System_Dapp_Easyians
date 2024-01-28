async function main() {
  const Voting = await ethers.getContractFactory("Voting");

  // Start deployment, returning a promise that resolves to a contract object
  const Voting_ = await Voting.deploy(
    ["0xACb82aC664843A14D2A47B3FCeAb7dd70b4452eC", "0x68c8e1711B1DbC7FB183a3fCf973E8C1266feCF7", "0x12A3Df5F3FE19D3f61e415480351e9ab2aCfa77b", "0x82a1C79F8cf9645898d7e31Ade942B8702868112"],  //Replace with all the records of voters who are elegible to cast a vote, with a public key mapped for each voter
    ["Akshay", "Ashwin", "Lok Visnu", "Vishrudh"],  // Replace with the records of all candidates participating in the voting process
    10 //Voting time i.e. the period for which the deployed contract which faciltates voting stays active
  );
  console.log("Contract address:", Voting_.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

