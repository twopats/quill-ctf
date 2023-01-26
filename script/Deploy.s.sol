// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "../lib/forge-std/src/Script.sol";
import "../src/PelusaSolution.sol";
import "../src/PelusaSolutionFactory.sol";
import "../instances/Pelusa.sol";
import {Create2} from "../lib/openzeppelin-contracts/contracts/utils/Create2.sol";


contract Deploy is Script {
    address  factoryAddress = vm.envAddress("PELUSA_FACTORY_ADDRESS");

    function run() public {
        vm.startBroadcast(vm.envUint("HH1PK"));

        uint32 i;
        while (i < 500) {
            bytes32 salt = bytes32(uint256(i));
            address expectedAddress = computeSolutionAddress(salt);
            if (uint256(uint160(expectedAddress)) % 100 == 10) {
                new PelusaSolutionFactory{salt: salt}(vm.envAddress("PELUSA_ADDRESS"));
                break;
            }
            i++;
        }

        vm.stopBroadcast();
    }

    function deploy(bytes32 _salt) public returns (address addr)  {
        bytes memory _bytecode = type(Pelusa).creationCode;
        return Create2.deploy(0, _salt, _bytecode);
    }
    function computeSolutionAddress(bytes32 _salt) public view returns (address) {
        bytes memory _bytecodeHash = type(Pelusa).creationCode;
        return Create2.computeAddress(_salt, keccak256(_bytecodeHash));
    }
}



        // PelusaSolutionFactory factory = PelusaSolutionFactory(factoryAddress);
        // PelusaSolution pelusaSolution = PelusaSolution(factory.solutionAddress());
        // pelusaSolution.attack();