pragma solidity 0.5.10;

contract Bank {
    mapping(address => uint) balances;
    
    function deposit() public payable {
        balances[tx.origin] += msg.value;
    }
    
    function transfer(address payable _to) public {
        uint amount = balances[tx.origin];
        require(amount > 0);
        balances[tx.origin] = 0;
        _to.transfer(amount);
    }
    
    function getMyBalance() public view returns(uint) {
        return balances[tx.origin];
    }
}