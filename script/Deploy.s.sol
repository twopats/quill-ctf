
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "../lib/forge-std/src/Script.sol";
import "../src/safeNFT.sol";

contract Deloy is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("PK"));
        // Solution solution = Solution(vm.envAddress("SOLUTION_ADDRESS"));
        Solution solution = new Solution();
        solution.buy{value:10000000000000000}();
        // solution.onERC721Received(0xf4CE225b2beaFA65CC155a9dE1B1a41FF5EB3B61,0xf4CE225b2beaFA65CC155a9dE1B1a41FF5EB3B61, 1,0xdedf56c1b30ec811643f);
        solution.claim{gas: 800000}(); 
        // solution.claim(); 
        vm.stopBroadcast();
    }
}
