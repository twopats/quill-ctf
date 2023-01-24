// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

const address = "";

async function main() {
    const [deployer] = await hre.ethers.getSigners();
    console.log("deploying from address %t", deployer.address)
    const CTF = await hre.ethers.getContractFactory("Pelusa");
    const ctf = await CTF.deploy();
    let tx = await ctf.deployed();
    console.log(`deployed CTF contract ${tx.address}`);
    console.log(hre.network.name);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});

