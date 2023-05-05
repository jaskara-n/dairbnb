const { ethers, deployments, getNamedAccounts } = require("hardhat");

async function main() {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  console.log("Deploying dairbnb...");

  const contract = await deploy("dairbnb", {
    from: deployer,
    args: [],
    log: true,
  });

  console.log("dairbnb deployed to:", contract.address);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
