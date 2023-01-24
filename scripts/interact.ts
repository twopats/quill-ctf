import hre from "hardhat";
import ctfArtifact from "../artifacts/instances/Pelusa.sol/Pelusa.json";

const ctfAddress = "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512";

const main = async () => {
  const ctfContract = await hre.ethers.getContractAt(
    ctfArtifact.abi,
    ctfAddress
  );
  //   console.log(ctfContract);
  const storageRead = await hre.ethers.provider.getStorageAt(ctfAddress, 2);
  console.log(storageRead);
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
