pragma solidity 0.5.10;

/**
 * Players can guess what number will occupy which slot
 * There are several rounds and participants will
 * automatically move to the next round if they succeed
 */
contract GuessingGame {
    struct Participant {
        mapping(uint8=>uint8) guesses;
        uint256 time;
        uint256 id;
        bool bonus;
    }
    
    mapping(address=>Participant) round1;
    mapping(address=>Participant) round2;

    /**
     * This function unintentionally contains a bug
     * Since guesses is a mapping, which is a storage variable,
     * it will be skipped when Struct is copied to memory.
     * This will set the guesses in round 2 as an empty mapping
     */
    function moveToNextRound(address player) internal {
        Participant memory tmp = round1[player]; //create temporary copy to save gas
        tmp.time = getCurrentTime(); 
        tmp.id = getPlayerId(player);
        tmp.bonus = getPlayerBonus(player);
        round2[player] = tmp;
    }
    
    function placeGuess(uint8[] memory slots, uint8[] memory guesses) public payable {
        //require(msg.value == 1 ether);
        //add test data when called
        //initializes player struct in round1
        for(uint256 i = 0; i < slots.length; i++) {
            round1[msg.sender].guesses[slots[i]] = guesses[i];
        }
        round1[msg.sender].time = 1234; //random data
        round1[msg.sender].id = 1234; //random data
        round1[msg.sender].bonus = false; //random data
    }
    
    function getCurrentTime() internal returns(uint) {
        //random data
        return 4321;
    }
    
    function getPlayerId(address player) internal returns(uint) {
        //random data
        return 4321;
    }
    
    function getPlayerBonus(address player) internal returns(bool) {
        //random data
        return true;
    }
    
    function getGuessRound1(uint8 slot) public view returns(uint8) {
        return round1[msg.sender].guesses[slot];
    }
    
    function getGuessRound2(uint8 slot) public view returns(uint8) {
        return round2[msg.sender].guesses[slot];
    }
    
    function testMoveToNextRound() public {
        moveToNextRound(msg.sender);
    }
}