object "Solution" {
    code {
        // Store the creator in slot zero.
        sstore(0, caller())
        // Deploy the contract
        datacopy(0, dataoffset("runtime"), datasize("runtime"))
        return(0, datasize("runtime"))
    }
    object "runtime" {
        code {
            //determine function call
            // switch shr(0x28,calldataload(0)) 
            // case 0xb616095d {
                let pos := add(4, mul(1, 0x20))
                if lt(calldatasize(), add(pos, 0x20)) {
                    revert(0, 0)
                }
                let n := calldataload(pos)
                switch div(n,2) 
                case 0 {
                    mstore(0, div(n,2))
                    return(0, 0x20)
                }
                default {
                    mstore(0, add(mul(3,n), 1))
                    return(0,0x20)
                }
            // }
            // default {}
        }
    }

}