pragma solidity 0.5.10;

contract WalletLibrary {
    // list of owners
    uint[256] owners;
    // index on the list of owners to allow reverse lookup
    mapping(uint => uint) ownerIndex;
 
    /**
     * constructor - just pass on the owner array to the multiowned
     * has no checks to prevent calling after initialization
     */
    function initWallet(address[] memory _owners) public{
        initMultiowned(_owners);
    }
    
    /**
     * Function to extract the constructor logic into a separate library
     */
    function initMultiowned(address[] memory _owners) public {
        owners[1] = uint(msg.sender);
        ownerIndex[uint(msg.sender)] = 1;
        for (uint i = 0; i < _owners.length; ++i){
            owners[2 + i] = uint(_owners[i]);
            ownerIndex[uint(_owners[i])] = 2 + i;
        }
    }
    
    /**
     * Check if address is owner
     */
    function isOwner(address _addr) public view returns (bool) {
        return ownerIndex[uint(_addr)] > 0;
    }
}