pragma solidity 0.5.10;

contract TokenSystem {
    
    mapping(address=>mapping(uint256=>uint256)) userTokens;
    mapping(address=>uint256) public balances;
    mapping(uint256=>uint256) public tokenPrices;
    /**
     * User can have bonus tokens that are added to sold amounts.
     * E.g. sell 1 tokens and contract adds 1 token, so you can sell 2 tokens
     */
    mapping(address=>uint256) public bonuses;
    
    /**
     * Sell multiple tokens at once
     */
    function batchSell(bytes memory data) public {
        (uint256[] memory tokenIds, uint256[] memory amounts) = 
            abi.decode(data, (uint256[],uint256[]));
        require(tokenIds.length == amounts.length);
        for(uint256 i=0; i < tokenIds.length; i++) {
            //check that sender has enough tokens to sell
            require(userTokens[msg.sender][tokenIds[i]] >= amounts[i]);
            
            userTokens[msg.sender][tokenIds[i]] -= amounts[i];
            amounts[i] += bonuses[msg.sender];
            bonuses[msg.sender] = 0;
            sellTokens(msg.sender, tokenIds[i], amounts[i]);
        }
    }
    
    function sellTokens(address seller, uint256 tokenId, uint256 amount) internal {
        uint256 tokenPrice = tokenPrices[tokenId];
        balances[seller] += amount * tokenPrice;
    }

    function setTestData() public {
        tokenPrices[0] = 5;
        tokenPrices[1] = 10;
        tokenPrices[2] = 15;
        tokenPrices[3] = 20;
        userTokens[msg.sender][0] = 10;
        userTokens[msg.sender][1] = 10;
        bonuses[msg.sender] = 1;
    }
}