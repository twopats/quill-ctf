// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "../lib/forge-std/src/Script.sol";
import "../src/CollatzPuzzle.solution.sol";
import "../instances/CollatzPuzzle.sol";

contract Deploy is Script {
    function run() public {
        address CTFAddress = 0x54C3124bDBEe862Fc97Aa09FfB45B7C95cB5E637;
        vm.startBroadcast(vm.envUint("PK"));
        Solution solution = new Solution();
        CollatzPuzzle target = CollatzPuzzle(CTFAddress);
        bool res = target.callMe(address(solution));
        require(res);
        vm.stopBroadcast();
    }
}
