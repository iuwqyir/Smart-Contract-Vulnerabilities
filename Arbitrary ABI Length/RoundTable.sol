pragma solidity 0.4.26;

contract BiddingInterface{
    function bid(uint[] memory seats, uint[] memory bids) public payable;
}

contract RoundTable is BiddingInterface {
    struct Seat {
        address owner;
        uint bid;
    }
    uint public ownerCut;
    address payable owner;
    mapping(uint8 => Seat) table;

    //in the ICO bid cap is set to 1
    uint8 public BID_CAP = 1;

    constructor() public payable {
        require(msg.value == 1 ether);
        owner = msg.sender;
        table[0].owner = msg.sender;
        table[0].bid = msg.value;
    }
    
    function getSeatOwner(uint8 seatNumber) public view returns(address) {
        return table[seatNumber].owner;
    }
    
    function getSeatBid(uint8 seatNumber) public view returns(uint) {
        return table[seatNumber].bid;
    }
    
    function bid(uint[] memory seats, uint[] memory bids) public payable {
        //protect against short address attack
        uint expected_size = 4 + 32*(2+BID_CAP) + 32*(2+BID_CAP);
        assert(msg.data.length == expected_size);
        assert(seats.length > 0);
        assert(seats.length == bids.length);
        
        for(uint i = 0; i < BID_CAP; i++) {
            //seat 0 is reserved for owner
            assert(seats[i] > 0 && seats[i] < 15);
            uint8 seatNr = uint8(seats[i]);
            uint bidValue = bids[i];
            
            //have to bet atleast 1 ether more
            if (table[seatNr].bid + 1 ether <= bidValue) {
                table[seatNr].owner = msg.sender;
                table[seatNr].bid = bidValue;
            } //else money is lost
        }
        //owner gets 100 Wei for each bet
        ownerCut += 100 * bids.length;
    }
    
    function getOwnerCut(uint value) public {
        require(msg.sender == owner);
        require(value <= ownerCut);
        ownerCut -= value;
        msg.sender.transfer(value);
    }
}