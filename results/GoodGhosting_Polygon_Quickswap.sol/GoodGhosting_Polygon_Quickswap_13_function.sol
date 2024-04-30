    function depositIntoExternalPool(uint256 _slippage)
        external
        whenNotPaused
        whenGameIsNotCompleted
    {
        uint256 currentSegment = getCurrentSegment();
        require(
            currentSegment > 0,
            "Cannot deposit into underlying protocol during segment zero"
        );
        uint256 amount = segmentDeposit[currentSegment.sub(1)];
        require(
            amount > 0,
            "No amount from previous segment to deposit into protocol"
        );
        // Sets deposited amount for previous segment to 0, avoiding double deposits into the protocol using funds from the current segment
        segmentDeposit[currentSegment.sub(1)] = 0;

        emit FundsDepositedIntoExternalPool(amount);
        uint256 musdcSwapAmt = amount.div(2);
        // swapping half the mtoken for matoken
        address[] memory pairTokens = new address[](2);
        pairTokens[0] = address(mtoken);
        pairTokens[1] = address(matoken);

        // getting the minAmount with slippage in consideration
        uint256 minAmount = getMinOutputAmount(musdcSwapAmt, _slippage);
        uint256[] memory amounts = router.swapExactTokensForTokens(
            musdcSwapAmt,
            minAmount,
            pairTokens,
            address(this),
            now.add(1200)
        );

        // since in path param we just have the 2 tokens hence checking the only element in the amounts array.
        require(<FILL_ME>)
        // adding liquidity to the pool
        (, , uint256 liquidity) = router.addLiquidity(
            address(mtoken),
            address(matoken),
            musdcSwapAmt,
            amounts[0],
            0,
            0,
            address(this),
            now.add(1200)
        );
        // this safety check is sufficient
        require(liquidity > 0, "LP token amount is 0");
        // staking the lp tokens to earn $QUICK rewards
        uint256 lpTokenAmount = pair.balanceOf(address(this));
        // no return param here
        stakingPool.stake(lpTokenAmount);
    }