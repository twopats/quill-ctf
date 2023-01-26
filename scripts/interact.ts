import hre, { ethers } from "hardhat";
import ctfArtifact from "../artifacts/instances/Pelusa.sol/Pelusa.json";
import { Pelusa } from "../typechain-types/instances/Pelusa.sol/index";

const ctfAddress = "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512";

const main = async () => {
  const ctfContract: Pelusa = (await hre.ethers.getContractAtFromArtifact(
    ctfArtifact,
    ctfAddress
  )) as Pelusa;
  //   console.log(ctfContract);
  console.log(Number(await ctfContract.goals()));
  const storageRead = await hre.ethers.provider.getStorageAt(ctfAddress, 2);
  hre.ethers.utils.k;
  // console.log(storageRead);
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
