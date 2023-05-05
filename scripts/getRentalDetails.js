const { ethers } = require("hardhat");
const abi = require("../artifacts/contracts/dairbnb.sol/dairbnb.json").abi;

async function getRentalDetails() {
  const contract = await ethers.getContractAt(
    abi,
    "0x558Fe06c949F0B2c712bf9B34eF6Bf86A6406531"
  );

  const rd = await contract.getRentalDetails(1);

  console.log(rd);
}

getRentalDetails().catch((error) => {
  console.error(error);
  process.exit(1);
});
