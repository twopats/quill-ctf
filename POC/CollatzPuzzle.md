### CollatzPuzzle

Solution by 2pats.eth

### Submission TX's

1. Link to tx calling callMe() of CTF contract https://goerli.etherscan.io/tx/0xe5bbd522936bd11614ad960ffb1683c219af6537ecefd9a718d2ffb6cde5be01

2. tx creating my contract on goerli: https://goerli.etherscan.io/tx/0xbb5e82a35a4b9f41c05c31f0741e282bc0e72c9853bdd10361c3fdbe44d23b8b

3. solution contract address `0x2746E405A7a670f290f085bF7e5466BcB2FcbeE31`

4. my EOA: `0xf4CE225b2beaFA65CC155a9dE1B1a41FF5EB3B61`

### Overview

solution contract runtime bytecode
`600435600281068160030260010181029160011c901502013d52593df3`
(29 bytes) in length
see walkthrough below

constructor bytecode
`601d600c600039601d6000f3`
(12 bytes in length)
see walkthrough below

deploy bytecode = intialization + runtime code
`601d600c600039601d6000f3600435600281068160030260010181029160011c901502013d52593df3`

### Runtime Solution Overview

```
1) retrieve n as argument from calldataload
2) compute condition n % 2 == 0 (even or odd)
3) compute 3n + 1
   1) if n is even, even throw this value away with zero multiplication
4) compute n / 2
   1) if n is odd, throw this value away with zero multiplication
5) store return value in memory at 0x00
6) return value at memory address 0x00 as MSIZE

**note, this solution uses RETURNDATASIZE to push 0 to the stack, which costs lower gas than PUSH1 0x00
```

### Runtime Opcode Solution Walkthrough

```
[00]	PUSH1	04
[02]	CALLDATALOAD
get "n" from calldata with offset 4 (to skip 4bytes of the function selector), in our case is uint256 from the CTF contract, variable "n" in its source code, coming from inside the callMe() func


[03]	PUSH1	02
push value 2 (in order to use for modulo division of the if statement of collatzIteration())

[05]	DUP2
DUP2, gives us a copy of n, saving the original n for future use

[06]	MOD
perform (n % 2), mathematically pushes only either 0 or 1 to the stack, this is useful later on when deciding which value to return

[07]	DUP2
DUP the original calldata value again

[08]	PUSH1	03
[0a]	MUL
[0b]	PUSH1	01
[0d]	ADD
perform 3n + 1

[0e]	DUP2
reference our isOdd value in the stack, (the 0 or 1 value from our modulo condition)

[0f]	MUL
if n is even, multiply by 0 effectively throwing away the 3n + 1  value
[10]	SWAP2

[11]	PUSH1	01
[13]	SHR
calculate n / 2, save to stack

[14]	SWAP1
[15]	ISZERO
[16]	MUL
if n is odd, multiply by 0 effectively throwing away the n / 2 value

[17]	ADD
this operation clears the stack by adding 0


[18]	RETURNDATASIZE
[19]	MSTORE
store return value at pos 0 in memory

[1a]	MSIZE
[1b]	RETURNDATASIZE
[1c]	RETURN
return MSIZE value at position0 of memory
```

### Deriving the initialization bytecode

Our initialization bytecode is 12 bytes long and needs to know the length of the runtime bytecode

```
[00]	PUSH1	1d
push length of run our time bytecode (29 bytes)

[02]	PUSH1	0c
push position at which this runtime bytecode starts (position 12)

[04]	PUSH1	00
[06]	CODECOPY
code copy to position 0 in memory

[07]	PUSH1	1d
[09]	PUSH1	00
[0b]	RETURN
return value at position 0 in memory size 29 bytes
```

### Deploy using foundry's cast tool

Foundry now has nice utility for deploy contract using its full bytecode, refer to this discussion https://github.com/foundry-rs/foundry/issues/2710

```
cast send --create 601d600c600039601d6000f3600435600281068160030260010181029160011c901502013d52593df3 --rpc-url $GOERLI_RPC --private-key $PK
```

- I have my PK and RPC endpoint in .env file
- I used https://www.evm.codes/playground to help format the opcodes for this MD file
