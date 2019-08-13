pragma solidity 0.5.10;

contract WalletLibrary {
    uint public numOwners;
    uint[256] owners;
    // index on the list of owners to allow reverse lookup
    mapping(uint => uint) ownerIndex;
    
    // throw unless the contract is not yet initialized.
    modifier only_uninitialized { require(numOwners == 0); _; }
    
    // constructor - just pass on the owner array to the multiowned 
    function initWallet(address[] memory _owners) public only_uninitialized {
        initMultiowned(_owners);
    }

    function initMultiowned(address[] memory _owners) public only_uninitialized {
        numOwners = _owners.length + 1;
        owners[1] = uint(msg.sender);
        ownerIndex[uint(msg.sender)] = 1;
        for (uint i = 0; i < _owners.length; ++i) {
            owners[2 + i] = uint(_owners[i]);
            ownerIndex[uint(_owners[i])] = 2 + i;
        }
    }
  
    function isOwner(address _addr) public view returns (bool) {
        return ownerIndex[uint(_addr)] > 0;
    }

    // kills the contract sending everything to `_to`.
    function kill(address payable _to)  external {
        if (isOwner(msg.sender)) {
            selfdestruct(_to);   
        }
    }
}