    function checkBuy(uint projectId, uint256 tokensToBuy) public view returns (bool) {
        // The project id is required
        require(projectId > 0, "ProjectId must be selected");
        require(_checkProjectExistById(projectId), "Project with this ID does not exist.");

        // Project info
        address contractAddress = projects[projectId].contractAddress;

        // We will check how many tokens there are in the contract account
        uint256 availableTokens = anyoneTokenBalance(contractAddress, address(this));
        require(<FILL_ME>)

        // We'll check to see if there are enough tokens to pay out in contract account
        require(tokensToBuy > 0, "Insufficient tokens to send");
        require(tokensToBuy < availableTokens, "Insufficient tokens in contract to send");

        // We will get the winner and check if there is still reward available
        LotteryWinner memory winner = getLotteryWinner(projectId, msg.sender);
        require(!winner.claimed, "User already claimed the reward");

        return true;
    }