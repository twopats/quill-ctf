pragma solidity 0.8.10;

import "forge-std/Test.sol";
import "../src/PelusaSolution.sol";
import "../src/PelusaSolutionFactory.sol";
import "../instances/Pelusa.sol";

contract PelusaSolutionTest is Test {
    uint256 testNumber;

    Pelusa pelusa = new Pelusa();
    PelusaSolution solution = new PelusaSolution(address(pelusa));

    function setUp() public {
        // testNumber = 42;
    }

    function testHandOfGod() public {
        (bool success, bytes memory data) = solution.handOfGod();
        assertTrue(success);
        assertEq(22_06_1968, (uint256(22_06_1968)));
    }
}
