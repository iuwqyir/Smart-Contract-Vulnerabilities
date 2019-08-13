pragma solidity 0.5.10;

/**
 * Contract generates a number on initialization,
 * which is based on block number and block timestamp.
 * If player guesses correctly, it will get the balance 
 * of the contract.
 */
contract GuessStatic {
    uint answer;
    
    constructor() public payable{
        answer = block.number * block.timestamp;
    }
    
    function play(uint _guess) public payable returns(bool) {
        require(msg.value == 1 ether);
        if(_guess == answer) {
            msg.sender.transfer(address(this).balance);
            return true;
        }
        return false;
    }
}