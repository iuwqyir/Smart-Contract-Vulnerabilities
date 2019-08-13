pragma solidity 0.5.10;

/**
 * Players try to guess each other's numbers
 * Whoever's guess is closer to the actual
 * number wins
 */
contract GuessEachOthersNumbers {
    struct Competitor {
        address payable pAddress;
        uint myNum;
        uint otherNum;
    }

    Competitor[2] private competitors;
    uint8 private nrOfCompetitors;

    function play(uint _myNum, uint _otherNum) public payable {
        require(msg.value == 1 ether);
        competitors[nrOfCompetitors] = Competitor(msg.sender, _myNum, _otherNum);
        nrOfCompetitors++;
        if (nrOfCompetitors == 2) {
            findWinner();
        }
    }
    
    function findWinner() public {
        require(nrOfCompetitors == 2);
        uint diff1 = getDiff(competitors[1].myNum, competitors[0].otherNum);
        uint diff2 = getDiff(competitors[0].myNum, competitors[1].otherNum);
        address payable winner;
        if (diff1 < diff2) {
            winner = competitors[0].pAddress;
        } else {
            winner = competitors[1].pAddress;
        }
        delete competitors;
        nrOfCompetitors = 0;
        winner.transfer(address(this).balance);
    }
    
    function getDiff(uint num1, uint num2) internal pure returns(uint) {
        if (num1 >= num2) {
            return num1 - num2;
        } else {
            return num2 - num1;
        }
    }
}