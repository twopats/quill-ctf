#!/bin/bash

source .env
# forge script ./script/Deploy.s.sol --private-key $PK --rpc-url $GOERLI_RPC --broadcast 
forge create ./instances/Pelusa.sol:Pelusa --private-key $HH1PK 
# cast send 0x54C3124bDBEe862Fc97Aa09FfB45B7C95cB5E637 "callMe(address)" 0x2746E405A7a670f290f085bF7e5466BcB2FcbeE3 --rpc-url $GOERLI_RPC --private-key $PK   
# # cascall 0x971e55F02367DcDd1535A7faeD0a500B64f2742d "hacked()" --rpc-url $GOERLI_RPC --private-key $PK  l 54C3124bDBEe862Fc97Aa09FfB45B7C95cB5E6372dcallMeeaddressd()" --rpc0x2746E405A7a670f290f085bF7e5466BcB2FcbeE3 -url $GOERLI_RPC --private-key $PK  all 0x971e55F02367DcDd1535A7faeD0a500B64f2742d "hacked()" --rpc-url $GOERLI_RPC --private-key $PK  2754C3124bDBEe862Fc97Aa09FfB45B7C95cB5E637adcallMe

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

