pragma solidity 0.5.10;

contract Safe {
    /**
     * Keeps track of users' balances
     */
    mapping(address => uint256) public balances;
    
    /**
     * Accepts the ether sent and increases sender's balance
     */
    function deposit() public payable{
        balances[msg.sender] += msg.value;
    }
    
    /**
     * Withdraws the amount in sender's balance and sets balance to 0
     */
    function withdraw() public {
        uint256 amount = balances[msg.sender];
        (bool succeed,) = msg.sender.call.value(amount)("");
        if (succeed) {
            balances[msg.sender] = 0;   
        }
    }
}