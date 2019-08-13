pragma solidity 0.5.10;

contract TokenBank {
    mapping(address => uint) public balances;
    SafeCalculation sc;
    uint256 constant price = 50000000000 wei;

    /**
     * Supply MaliciousSafeCalculation.sol address
     */
    constructor(address _safeCalculationAddr) public {
        sc = SafeCalculation(_safeCalculationAddr);
    }
    
    function buy() public payable {
        uint tokenAmount = sc.safeDivide(msg.value, price);
        require(tokenAmount > 0);
        balances[msg.sender] += tokenAmount;
    }
    
    function sell(uint _amount) public {
        require(balances[msg.sender] >= _amount);
        uint value = sc.safeMultiply(_amount, price);
        balances[msg.sender] -= _amount;
        msg.sender.transfer(value);
    }
}

contract SafeCalculation {
    function safeMultiply(uint a, uint b) public pure returns(uint) {
        if (a == 0) {return 0;}
        uint256 c = a * b;
        require(c / a == b, "Multiplication overflow");
        return c;
    }
    function safeDivide(uint a, uint b) public pure returns(uint) {
        require(b > 0, "Division by zero");
        uint256 c = a / b;
        return c;
    }
}