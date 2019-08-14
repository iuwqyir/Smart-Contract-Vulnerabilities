pragma solidity 0.4.24;

contract Wallet {
    mapping(address => uint) public balances;
    uint public latestSize;
    bytes public data;

    function() external payable {}

    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }
    
    function addTokens(address _receiver, uint _amount) internal {
        balances[_receiver] += _amount;
    }
    
    /**
     * If a shorter address is supplied, missing bytes are taken
     * from 'amount' and 'amount' will be padded with zeroes.
     * This will multiply its value.
     */
    function transferTo(address _to, uint _amount) public {
        require(_amount <= balances[msg.sender]);
        latestSize = msg.data.length;
        data = msg.data;
        balances[msg.sender] -= _amount;
        addTokens(_to, _amount);
    }
}
