pragma solidity ^0.8.17;

interface IGuardian {
    function f00000000_bvvvdlt() external view returns (address);

    function f00000001_grffjzz() external view returns (address);
}

contract Gate {
    bool public opened;

    function open(address guardian) external {
        uint256 codeSize;
        assembly {
            codeSize := extcodesize(guardian)
        }

        require(codeSize < 33, "bad code size");

        //3d3d0587
        require(
            IGuardian(guardian).f00000000_bvvvdlt() == address(this),
            "invalid pass"
        );
        //26964fd8
        require(
            IGuardian(guardian).f00000001_grffjzz() == tx.origin,
            "invalid pass"
        );

        //3b2564d7
        (bool success, ) = guardian.call(abi.encodeWithSignature("fail()"));
        require(!success, "fail() failed");

        opened = true;
    }
}