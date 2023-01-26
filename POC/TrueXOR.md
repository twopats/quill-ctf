### TrueXOR

solution by 2pats.eth

### POC & Walkthrough

Since we are restrained to working only inside a view function, we don't have much to build a conditional with. But gasleft() is accessible globally and we can use it as for our switch.

```
//TrueXORSolution.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../instances/TrueXOR.sol";
import "../lib/forge-std/src/console.sol";

contract TrueXORSolution is IBoolGiver {

    //view functions cost gas when called internally, we can use it for our burn mechanism
    function burnGas(uint256 _lowestLimit) internal view {
        uint256 counter = 0;

        //solidity gasleft leaves some extra gas in practice , so we just pad our condition with -1200 to even that out
        while(gasleft() > _lowestLimit - 1200) counter++;
    }

    function giveBool() external view  returns  (bool) {
        uint256 gas = gasleft();

        //designated gas threshold to flip the condition
        uint256 end = 4000;

        if (gas > end) {
            burnGas(end);
            return true;
        }
        return false;
    }
}


```
