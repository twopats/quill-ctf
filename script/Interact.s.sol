pragma solidity ^0.8.0;

import "../lib/forge-std/src/Script.sol";
import "../instances/Pelusa.sol";

contract Interact is Script {
    function run() public {
        Pelusa pelusa = Pelusa(vm.envAddress("PELUSA_ADDRESS"));
        vm.startBroadcast(vm.envUint("HH1PK"));
    }

}
