    function updateStakingContract(IStake _stakingPool) external onlyOwner {
        require(address(_stakingPool) != address(0), "Invali Address");
        require(<FILL_ME>)

        stakingPool.exit();
        stakingPool = _stakingPool;
        // staking the lp tokens to earn $QUICK rewards
        uint256 lpTokenAmount = pair.balanceOf(address(this));
        // no return param here
        stakingPool.stake(lpTokenAmount);
    }

    function _transferDaiToContract() internal {