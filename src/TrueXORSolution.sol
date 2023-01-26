// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../instances/TrueXOR.sol";
import "../lib/forge-std/src/console.sol";

contract TrueXORSolution is IBoolGiver {
    function burnGas(uint256 _lowestLimit) internal view {
        uint256 counter = 0;
        while(gasleft() > _lowestLimit - 1200) counter++;
    }

    function giveBool() external view  returns  (bool) {
        uint256 gas = gasleft();
        uint256 end = 4000;
        if (gas > end) { 
            burnGas(end);
            return true;
        }
        return false;
    }
}
