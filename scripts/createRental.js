const { ethers } = require("hardhat");
const abi = require("../artifacts/contracts/dairbnb.sol/dairbnb.json").abi;

async function createRental() {
  const contract = await ethers.getContractAt(
    abi,
    "0x558Fe06c949F0B2c712bf9B34eF6Bf86A6406531"
  );

  contract.createRental(
    1,
    "name",
    "description",
    ["exampleimageurl"],
    600,
    "contact",
    "add",
    6,
    "jaipur",
    "india"
  );

  console.log("rental created!");
}

createRental().catch((error) => {
  console.error(error);
  process.exit(1);
});
