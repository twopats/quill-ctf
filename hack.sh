#!/bin/bash

source .env
forge script ./script/VIPBank.s.sol --private-key $PK --rpc-url $GOERLI_RPC --broadcast 
# cast call $SOLUTION_ADDRESS "attack()" --rpc-url $GOERLI_RPC --private-key $PK --value 0.001ether

# cast storage 0xf8E9327E38Ceb39B1Ec3D26F5Fad09E426888E66 3 --rpc-url $GOERLI_RPC
# cast storage 0xf8E9327E38Ceb39B1Ec3D26F5Fad09E426888E66 8 --rpc-url $GOERLI_RPC
# forge script ./script/Confidential.s.sol --rpc-url $GOERLI_RPC --broadcast  
# cast call $VIP_BANK "contractBalance()(uint)" --rpc-url $GOERLI_RPC
# cast call $VIP_BANK "withdraw(uint)(uint)" 100 --rpc-url $GOERLI_RPC
# cast call $VIP_BANK "deposit(uint)" 100 --rpc-url $GOERLI_RPC
# cast storage $VIP_BANK 0 --rpc-url $GOERLI_RPC

# cast storage 0xf8E9327E38Ceb39B1Ec3D26F5Fad09E426888E66 3 --rpc-url $GOERLI_RPC
# cast storage 0xf8E9327E38Ceb39B1Ec3D26F5Fad09E426888E66 8 --rpc-url $GOERLI_RPC
# forge script ./script/Confidential.s.sol --rpc-url $GOERLI_RPC --broadcast  
# cast call $VIP_BANK "contractBalance()(uint)" --rpc-url $GOERLI_RPC
# cast call $VIP_BANK "withdraw(uint)(uint)" 100 --rpc-url $GOERLI_RPC
# cast call $VIP_BANK "deposit(uint)" 100 --rpc-url $GOERLI_RPC
# cast storage $VIP_BANK 0 --rpc-url $GOERLI_RPC

