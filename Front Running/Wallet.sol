pragma solidity 0.5.10;

/**
 * If the owner changes someone's allowance
 * then that user can withdraw their allowance
 * in the same block and have their transaction
 * executed first if they specify a higher gas price
 * than the owner
 */
contract Wallet {
    address payable owner;
    mapping(address => uint) public allowance;
    
    function getAllowance(uint _amount) public {
        /*Logic to withdraw allowance*/
    }

    function setAllowance(address _person, uint _amount) public {
        require(msg.sender == owner);
        allowance[_person] = _amount;
    }

    constructor() public {owner = msg.sender;}
}