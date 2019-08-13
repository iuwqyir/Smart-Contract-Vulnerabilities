pragma solidity 0.5.10;

contract TokenBank {
    mapping(address=>uint) public balances;
    /**
     * Number of tokens that are added to the amount sold
     */
    mapping(address=>uint) bonuses;
    
    function sellTokens(uint amount) public returns(uint){
        uint amountToSell = getTokensToSell(msg.sender, amount);
        transferEther(msg.sender, amountToSell);
    }
    
    /**
     * Checks if user has enough balance
     * and adds bonus amount to sold amount, if it exists
     */
    function getTokensToSell(address seller, uint requested) 
        private view 
        returns (uint256 amount) {
        if(balances[seller] >= requested)
            amount = requested;
            if(bonuses[seller] > 0)
                amount += bonuses[seller];
        else
            amount = 0;
    }
    
    function transferEther(address payable seller, uint amount) private {
        if (amount > 0) {
            balances[seller] -= amount;
            seller.transfer(amount);
        }
    }
    
    function buyTokens() public {
        balances[msg.sender] += 100;
    }
    
    function buyBonus() public {
        bonuses[msg.sender] += 5;
    }
}