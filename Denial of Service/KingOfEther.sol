pragma solidity 0.5.10;

/**
 * Whoever is willing to pay the most gets to be the king.
 * You can take over the king, when you pay more than current price.
 * Dethroned king will get the amount the new king payed
 */
contract KingOfEther {
    uint price;
    address payable king;
    
    function () external payable{}
    
    function takeOver() public payable{
        require(msg.value > price);
        king.transfer(msg.value);
        king = msg.sender;
        price = msg.value;
    }
    
    function getCurrentPrice() public view returns(uint) {
        return price;
    }
    
    function getCurrentKing() public view returns(address payable) {
        return king;
    }
}