    function getLotteryWinner(uint projectId, address userAddress) public view returns (LotteryWinner memory) {
        uint256 index = projectWinnerIndex[projectId][userAddress];
        require(<FILL_ME>)
        return lotteryWinners[projectId][index];
    }