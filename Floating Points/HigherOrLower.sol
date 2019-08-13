pragma solidity 0.5.10;

contract HigherOrLower {
    address payable private owner;
    
    uint256 public poolHigher;
    uint256 public poolLower;
    
    mapping(address => uint) balances;
    address[] public addressesHigher;
    address[] public addressesLower;

    bool private releaseFunds = false;

    uint public target;
    uint public result;
    
    constructor() public {
        owner = msg.sender;
        //generate random target
        target = 20000;
    }
    
    function() external payable{}
    
    function resolve() public {
        require(msg.sender == owner);
        //generate random number
        result = 100;
        divideWinnings();
    }
    
    function divideWinnings() internal {
        //prize money comes from loser pool
        uint prizeMoney = result > target ? poolLower : poolHigher;
        address[] memory winners = result > target ? addressesHigher : addressesLower;
        address[] memory losers = result > target ? addressesLower : addressesHigher;
        //if there aren't 2x more winners than losers, then prizePerPerson will be 0 
        //since there are no floating points
        uint prizePerPerson = prizeMoney / winners.length;
        for (uint i = 0; i < winners.length; i++) {
            address w = winners[i];
            balances[w] += prizePerPerson;
        }
        for (uint i = 0; i < losers.length; i++) {
            address l = losers[i];
            balances[l] = 0;
        }
        releaseFunds = true;
        delete(addressesHigher);
        delete(addressesLower);
    }
    
    function bet(bool _isHigher) public payable {
        require(msg.value == 1 ether);
        require(target != 0);
        balances[msg.sender] = 1 ether;
        if (_isHigher) {
           poolHigher++;
           addressesHigher.push(msg.sender);
        } else {
            poolLower++;
            addressesLower.push(msg.sender);
        }
    }
    
    function collect() public {
        require(releaseFunds);
        uint amount = balances[msg.sender];
        require(amount > 0);
        balances[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
    
    function getContractBalance() view public returns(uint){
        return address(this).balance;
    }
}