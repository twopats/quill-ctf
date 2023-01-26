// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "../src/TrueXORSolution.sol";
import "../instances/TrueXOR.sol";
import "../lib/forge-std/src/Script.sol";

contract Deploy is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("HH1PK"));
        TrueXOR ctf = new TrueXOR();
        TrueXORSolution solution = new TrueXORSolution();
        ctf.callMe{gas: 10_000}(address(solution));
        vm.stopBroadcast();
    }
}



        // PelusaSolutionFactory factory = PelusaSolutionFactory(factoryAddress);
        // PelusaSolution pelusaSolution = PelusaSolution(factory.solutionAddress());
        // pelusaSolution.attack();