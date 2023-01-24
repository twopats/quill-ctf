// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../instances/TrueXOR.sol";

contract TrueXORSolution is IBoolGiver {
    function burnGas(uint8 a, uint8 b) internal pure returns (uint16) {
        return a + b;
    }

    function giveBool() external view returns (bool) {
        uint256 start = gasleft();
        uint256 end = 2300;
        if (start < end) { return false; }
        while (gasleft() <= start && gasleft() > end) {
            burnGas(1,2);
        }
        return true;
    }
}
