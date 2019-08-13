pragma solidity 0.5.10;

contract Tokenator {
    
    uint constant PRICE = 1 ether;

    mapping(address => uint) balances;
    
    constructor() public payable {
        require(msg.value == 10 ether);
    }

    /**
     * Take out max uint's (2**256 - 1) last 18 digits //115792089237316195423570985008687907853269984665640564039457
     * (1 ether = 10**18 and it's int so no floating point after dividing)
     * Add 1 to make multiplication overflow //115792089237316195423570985008687907853269984665640564039458
     * Specify the tx value as the overflown amount //415992086870360064
     */
    function buy(uint _amount) public payable {
        require(msg.value == _amount * PRICE);
        balances[msg.sender] += _amount;
    }

    function sell(uint _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] -= _amount;
        address(msg.sender).transfer(_amount * PRICE);
    }
    
    function getBalance(address addr) public view returns(uint) {
        return balances[addr];
    }
}