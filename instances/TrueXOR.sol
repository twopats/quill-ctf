// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IBoolGiver {
    function giveBool() external view returns (bool);
}

contract TrueXOR {
    function callMe(address target) external view returns (bool) {
        bool q = IBoolGiver(target).giveBool();
        bool p = IBoolGiver(target).giveBool();
        require((p && q) != (p || q), "bad bools");
        require(msg.sender == tx.origin, "bad sender");
        return true;
    }
}

