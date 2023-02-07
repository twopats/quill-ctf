import "../lib/forge-std/src/Test.sol";
import "../instances/WETH10.sol";
import "../src/WETH10Solution.sol";

contract Weth10Test is Test {
    WETH10 public weth;
    address owner;
    address bob;
    WETH10Solution public solution;

    function setUp() public {
        weth = new WETH10();
        bob = makeAddr("bob");
        // WETH10Solution solution = new WETH10Solution(payable(address(weth)));
        solution = new WETH10Solution(payable(address(weth)));
        

        vm.deal(address(weth), 10 ether);
        vm.deal(address(bob), 1 ether);
    }

    function testHack() public {
        assertEq(address(weth).balance, 10 ether, "weth contract should have 10 ether");


        vm.startPrank(bob);

        solution.exploit{value: 1}();

        vm.stopPrank();
        // assertEq(address(weth).balance, 0, "empty weth contract");
        // assertEq(bob.balance, 11 ether, "player should end with 11 ether");
    }
}
