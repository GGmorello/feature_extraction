    function updateStakingContract(IStake _stakingPool) external onlyOwner {
        require(<FILL_ME>)
        require(
            address(_stakingPool) != address(stakingPool),
            "Same Staking Pool Address"
        );
        stakingPool.exit();
        stakingPool = _stakingPool;
        // staking the lp tokens to earn $QUICK rewards
        uint256 lpTokenAmount = pair.balanceOf(address(this));
        // no return param here
        stakingPool.stake(lpTokenAmount);
    }