pragma solidity 0.5.10;

contract ForceEther {
    
    function kill(address payable _addr) public {
        selfdestruct(_addr);
    }
}