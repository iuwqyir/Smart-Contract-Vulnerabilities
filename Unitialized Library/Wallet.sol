pragma solidity 0.5.10;

contract Wallet {
    
    // pointer used to find a free slot in m_owners
    uint public numOwners;

    uint[256] owners;
    
    mapping(uint => uint) ownerIndex;

    //placeholder - replace with correct address
    address libraryAddress = 0xca5968CC81F303f70D77bF3316C57E12Dc7c49F5;

    /**
     * Since initWallet is probably only called through the contract
     * and not on the WalletLibrary itself, then WalletLibrary won't be initialized.
     * Therefore anyone can set themselves as the owner of the library instance
     * and call any function they wish, such as "kill"
     */
    constructor(address[] memory _owners) public {
        // Signature of the Wallet Library's init function
        bytes4 sig = bytes4(keccak256("initWallet(address[])"));
        uint256 pointer = uint256(32);
        (bool status,) = libraryAddress.delegatecall(abi.encodePacked(sig, pointer, _owners.length, _owners));
    }
    /**
     * Big mistake to forward call to library as 
     * this fallback function is called when no signature
     * matches called function and so you can call library function externally
     */
    function() external payable {
        if (msg.value > 0){
            //just receive cash
        } else if (msg.data.length > 0){
            //forward call to library
            (bool result, bytes memory data) = libraryAddress.delegatecall(msg.data);
        }
    }
    // Gets an owner by 0-indexed position (using numOwners as the count)
    function getOwner(uint _ownerIndex) public view returns (address) {
        return address(owners[_ownerIndex + 1]);
    }
}