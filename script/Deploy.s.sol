
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "../lib/forge-std/src/Script.sol";
import "../src/Solution.sol";

contract Deloy is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("PK"));
        Solution solution = Solution(vm.envAddress("SOLUTION_ADDRESS"));
        solution.attack{value:}();
        vm.stopBroadcast();
    }
}
