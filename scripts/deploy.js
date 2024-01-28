async function main() {
  const Voting = await ethers.getContractFactory("Voting");

  // Start deployment, returning a promise that resolves to a contract object
  const Voting_ = await Voting.deploy(
    [
      "0x12A3Df5F3FE19D3f61e415480351e9ab2aCfa77b",
      "0x131835502be0eE53225386F7E6C5bb6228ab1509",
      "0xB1226f90Ace2C0cde46f54f80E462089F4510f40",
    ], //Replace with all the records of voters who are elegible to cast a vote, with a public key mapped for each voter
    [
      "Akshay",
      "Ashwin",
      "Lok Visnu",
      "Vishrudh",
      "Akshay",
      "Ashwin",
      "Lok Visnu",
      "Vishrudh",
    ], // Replace with the records of all candidates participating in the voting process
    30 //Voting time i.e. the period for which the deployed contract which faciltates voting stays active
  );
  console.log("Contract address:", Voting_.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
