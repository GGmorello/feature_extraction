    function setLotteryWinnerClaimedStatus(uint projectId, address userAddress) internal {
        uint256 index = projectWinnerIndex[projectId][userAddress];
        require(<FILL_ME>)
        lotteryWinners[projectId][index].claimed = true;
    }