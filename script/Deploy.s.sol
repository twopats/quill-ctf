// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// import "../src/WETH10Solution.sol";
// import "../instances/WETH10.sol";
import "../src/GateSolution.sol";
import "../instances/Gate.sol";
import "../lib/forge-std/src/Script.sol";

contract Deploy is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("HH1PK"));
        Gate ctf = new Gate();
        // GateSolution ctf = new GateSolution();
        // WETH10Solution solution = new WETH10Solution(payable(address(ctf)));
        // solution.exploit{value: 1}();
        vm.stopBroadcast();
    }
}



        // PelusaSolutionFactory factory = PelusaSolutionFactory(factoryAddress);
        // PelusaSolution pelusaSolution = PelusaSolution(factory.solutionAddress());
        // pelusaSolution.attack();