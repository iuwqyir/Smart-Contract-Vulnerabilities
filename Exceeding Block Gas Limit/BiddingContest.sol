pragma solidity 0.5.10;

/**
 * Everyone can place bids and then owner calls determineWinner()
 * If you were not the winner you get refunded 50%
 */
contract BiddingContest {
    struct Bid {
        address payable bidder;
        uint bidAmount;
    }
    address owner;
    Bid[] bids;
    mapping(address => uint) payouts;
    Bid public winner;
    
    constructor() public {owner = msg.sender;}
    
    /**
     * If there are enough bidders then the gas cost for this function may 
     * become higher than the gas limit so it would not be possible to execute
     */
    function determineWinner() public returns(uint256) {
        uint256 start = gasleft();
        require(msg.sender == owner);
        Bid memory highestBid;
        uint winnings = 0;
        for(uint i = 0; i < bids.length; i++) {
            Bid memory current = bids[i];
            if (current.bidAmount > highestBid.bidAmount) {
                //if not first bidder, take 50% of previous highet bid
                if (highestBid.bidAmount != 0) {
                    uint amount = highestBid.bidAmount / 2;
                    payouts[highestBid.bidder] = amount;
                    winnings += amount;
                }
                highestBid = current;
            } else {
                uint amount = current.bidAmount / 2;
                payouts[current.bidder] = amount;
                winnings += amount;
            }
        }
        winner = highestBid;
        payouts[winner.bidder] = winnings;
        return start - gasleft();
    }

    function bid() public payable {
        require(msg.sender != owner);
        Bid memory b = Bid(msg.sender, msg.value);
        bids.push(b);
    }
    
    function getPayout() public {
        require(payouts[msg.sender] > 0);
        msg.sender.transfer(payouts[msg.sender]);
    }
    
    function getWinner() public view returns(address) {
        return winner.bidder;
    }
}