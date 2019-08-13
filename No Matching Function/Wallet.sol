pragma solidity 0.5.10;

contract Wallet {
    uint[256] public owners;
    mapping(uint => uint) ownerIndex;
    //placeholder - replace with correct library address
    address libraryAddress = 0x692a70D2e424a56D2C6C27aA97D1a86395877b3A;
    
    constructor(address[] memory _owners) public {
        // Signature of the Wallet Library's init function
        bytes4 sig = bytes4(keccak256("initWallet(address[])"));
        uint256 pointer = uint256(32);
        libraryAddress.delegatecall(abi.encodePacked(sig, pointer, _owners.length, _owners));
    }
    
    /**
     * Big mistake to forward call to library as 
     * this fallback function is called when no signature
     * matches called function and so you can call library function externally
     */
    function() external payable {
        if (msg.value > 0){
        } else if (msg.data.length > 0){
            libraryAddress.delegatecall(msg.data);
        }
    }
    
    function withdraw() public {
        bool _isOwner = this.isOwner(msg.sender);
        require(_isOwner);
    }
    
    function isOwner(address _addr) public returns (bool) {
        (bool exec, bytes memory _data) = libraryAddress.delegatecall(msg.data);
        require(exec);
        bool result;
        assembly {result := mload(add(_data, 32))}
        return result;
    }
}