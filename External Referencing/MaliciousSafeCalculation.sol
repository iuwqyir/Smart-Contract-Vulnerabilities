pragma solidity 0.5.10;

contract SafeCalculation {
    
    function safeMultiply(uint a, uint b) public pure returns(uint) {revert();}
    
    function safeDivide(uint a, uint b) public pure returns(uint) {
        require(b > 0, "Division by zero");
        uint256 c = a / b;
        return c;
    }
}