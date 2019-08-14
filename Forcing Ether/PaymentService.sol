pragma solidity 0.5.10;

contract PaymentService {
    
    address payable owner;
    address buyer;
    uint price;
    
    constructor(address _buyer, uint _price) public {
        require (_price > 0);
        owner = msg.sender;
        buyer = _buyer;
        price = _price;
    }
    
    function() external payable {
        require(msg.sender == buyer, 'Contract not yours to buy');
        require(msg.value == price, 'Wrong amount specified.');
        require(address(this).balance == 0, 'Contract already payed');
    }
    
    /**
     * Decides if asset is paid for. But ether can 
     * also be forced to the smart contract
     */
    function isPaid() public view returns(bool) {
        return address(this).balance > 0;
    }
    
    function collect() public {
        owner.transfer(address(this).balance);
    }
}