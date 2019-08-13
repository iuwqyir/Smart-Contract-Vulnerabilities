pragma solidity 0.5.10;

contract Tokens {
    
    uint8 constant TOKEN_AMOUNT = 10;

    mapping(address => uint) balances;
    
    constructor() public payable {
        require(msg.value == 10 ether);
    }

    function buy() public payable {
        require(msg.value == 1 ether);
        balances[msg.sender] += TOKEN_AMOUNT;
    }

    /**
     * If amount is larger than balance, then it underflows
     * and adds a huge amount of tokens to account balance
     */
    function sell(uint _amount) public {
        require(balances[msg.sender] - _amount >= 0);
        balances[msg.sender] -= _amount;
        address(msg.sender).transfer(1 ether / TOKEN_AMOUNT * _amount);
    }
    
    function getBalance(address addr) public view returns(uint) {
        return balances[addr];
    }
}