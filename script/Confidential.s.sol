// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console.sol";
import "../src/Confidential.sol";

contract Hack {
    //address given by the CTF prompt
    address targetAddress = 0xf8E9327E38Ceb39B1Ec3D26F5Fad09E426888E66;
    Confidential target = Confidential(targetAddress);

    // alice hash at storage slot 4
    bytes32 A = 0x448e5df1a6908f8d17fae934d9ae3f0c63545235f8ff393c6777194cae281478;
    //bob hash at stirage slot 9
    bytes32 B = 0x98290e06bee00d6b6f34095a54c4087297e3285d457b140128c1c2f3b62a41bd;

    //solver
    function run() public view {
        //use the hash function given by the CTF contract
        bytes32 hash = target.hash(A, B);

        //check of that hash is valid
        bool result = target.checkthehash(hash);

        //if true, we pass
        console.logBool(result);
    }
}
