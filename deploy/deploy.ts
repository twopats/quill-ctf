import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
  const [deployer] = await hre.ethers.getSigners();
  console.log("deploying from address %t", deployer.address);
  const CTF = await hre.ethers.getContractFactory("Pelusa");
  const ctf = await CTF.deploy();
  let tx = await ctf.deployed();
  console.log(`deployed CTF contract ${tx.address}`);
  console.log(hre.network.name);
  const owner = await hre.ethers.provider.getStorageAt(tx.address, 0);
  console.log(owner);
};

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
export default func;
