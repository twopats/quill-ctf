// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./PelusaSolution.sol";

contract PelusaSolutionFactory {
    address public solutionAddress;
    constructor(address _target) {
        solutionAddress = address(new PelusaSolution(_target)); 
    }
}
