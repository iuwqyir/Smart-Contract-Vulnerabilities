pragma solidity 0.4.24;

contract Wallet {
    mapping(address => uint) public balances;
    uint public latestSize;
    bytes public data;

    function() external payable {}

    /**
     * Arbitrary function to add tokens
     */
    function deposit() public {
        balances[msg.sender] += 1000;
    }
    
    function addTokens(address _receiver, uint _amount) internal {
        balances[_receiver] += _amount;
    }
    
    function transferTo(address _to, uint _amount) public {
        require(_amount <= balances[msg.sender]);
        latestSize = msg.data.length;
        data = msg.data;
        balances[msg.sender] -= _amount;
        addTokens(_to, _amount);
    }
}