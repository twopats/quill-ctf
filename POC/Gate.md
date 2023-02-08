### Gate

Solution by 2pats.eth

### init opcode + breakdown

init bytecode can be as long as we need it to be
init bytecode:

`73f4CE225b2beaFA65CC155a9dE1B1a41FF5EB3B6160015573e7f1725e7734ce288f8367e1bb143e90bb3f051260005560016002556016604160003960166000f3`

breakdown:

[00] PUSH20 f4CE225b2beaFA65CC155a9dE1B1a41FF5EB3B61
[15] PUSH1 01
[17] SSTORE
store our EOA address (hardhat account 1) in storage slot 1 of solution contract

[18] PUSH20 e7f1725e7734ce288f8367e1bb143e90bb3f0512
[2d] PUSH1 00
[2f] SSTORE
store target ctf address (IMPORTANT: address will vary based on ctf contract creation conditions) storage slot 0

[30] PUSH1 01
[32] PUSH1 02
[34] SSTORE
store (true) in slot 2

[35] PUSH1 16
[37] PUSH1 41
[39] PUSH1 00
[3b] CODECOPY
code copy 22 bytes (runtime codesize) starting at position 65 (derived from the length of our init code length) to memory address 0

[3c] PUSH1 16
[3e] PUSH1 00
[40] RETURN
return 22 bytes long runtime code from memory at 0x00

### runtime bytecode

the three function signatures we are interested and their encoding are as follows

f00000000_bvvvdlt() | 0x00000000
f00000001_grffjzz() | 0x00000001
fail() | 0xa9cc4718

note that we initiated our storage like so:

slot 0 == return value of selector a9cc4718
slot 1 == return value of selector 00000001
slot 2 == return value of selector 00000000

- we will do math on the stack that results either in 0, 1, or 2
- at the end we will SLOAD at slot of the resulting index from the math

(22 bytes long)
`60003560E01c801560029091100154602052602059f3`

[00] PUSH1 00
[02] CALLDATALOAD
get calldata function selector

[03] PUSH1 E0
[05] SHR
shift right 28 bytes because selector is 4 bytes long

[06] DUP1
dupe this function selector

[07] ISZERO
first selector check:
selector == 00000000 ?
results of this based on selector

- 0x00000000 --> 1
- 0x00000001 --> 0
- 0xa9cc4718 --> 0

[08] PUSH1 02
[0a] SWAP1
[0b] SWAP2
set up next check on the stack

[0c] LT
second selector check:
selector < 2 ?
results of this based on selector:

- 0x00000000 --> 1
- 0x00000001 --> 1
- 0xa9cc4718 --> 0

[0d] ADD
add the two values from each check, the possible paths for each selector:

- 0x00000000 --> 1 + 1 = 2
- 0x00000001 --> 0 + 1 = 1
- 0xa9cc4718 --> 0 + 0 = 0
  we will use the result of this math as index of SLOAD

[0e] SLOAD

[0f] PUSH1 20
[11] MSTORE
push value from SLOAD to memory at 0x20

[12] PUSH1 20
[14] MSIZE
[15] RETURN
return that value

### full byte code for deploying

73f4CE225b2beaFA65CC155a9dE1B1a41FF5EB3B6160015573e7f1725e7734ce288f8367e1bb143e90bb3f051260005560016002556016604160003960166000f360003560E01c801560029091100154602052602059f3
