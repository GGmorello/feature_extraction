    function rebalance(
        int24 _baseLower,
        int24 _baseUpper,
        int24 _limitLower,
        int24 _limitUpper,
        address feeRecipient,
        uint256[4] memory inMin, 
        uint256[4] memory outMin
    ) nonReentrant external onlyOwner {
        require(<FILL_ME>)

        require(
            _limitLower < _limitUpper &&
                _limitLower % tickSpacing == 0 &&
                _limitUpper % tickSpacing == 0
        );
        require(
          _limitUpper != _baseUpper ||
          _limitLower != _baseLower
        );
        require(feeRecipient != address(0));

        /// update fees
        (uint128 baseLiquidity, uint128 limitLiquidity) = zeroBurn();

        /// Withdraw all liquidity and collect all fees from Uniswap pool
        (, uint256 feesLimit0, uint256 feesLimit1) = _position(baseLower, baseUpper);
        (, uint256 feesBase0, uint256 feesBase1) = _position(limitLower, limitUpper);

        uint256 fees0 = feesBase0.add(feesLimit0);
        uint256 fees1 = feesBase1.add(feesLimit1);
        (baseLiquidity, , ) = _position(baseLower, baseUpper);
        (limitLiquidity, , ) = _position(limitLower, limitUpper);

        _burnLiquidity(baseLower, baseUpper, baseLiquidity, address(this), true, outMin[0], outMin[1]);
        _burnLiquidity(limitLower, limitUpper, limitLiquidity, address(this), true, outMin[2], outMin[3]);

        /// transfer 10% of fees for VISR buybacks
        if (fees0 > 0) token0.safeTransfer(feeRecipient, fees0.div(10));
        if (fees1 > 0) token1.safeTransfer(feeRecipient, fees1.div(10));

        emit Rebalance(
            currentTick(),
            token0.balanceOf(address(this)),
            token1.balanceOf(address(this)),
            fees0,
            fees1,
            totalSupply()
        );

        uint256[2] memory addMins = [inMin[0],inMin[1]];
        baseLower = _baseLower;
        baseUpper = _baseUpper;
        addLiquidity(
          baseLower,
          baseUpper,
          address(this),
          token0.balanceOf(address(this)),
          token1.balanceOf(address(this)),
          addMins 
        );

        addMins = [inMin[2],inMin[3]];
        limitLower = _limitLower;
        limitUpper = _limitUpper;
        addLiquidity(
          limitLower,
          limitUpper,
          address(this),
          token0.balanceOf(address(this)),
          token1.balanceOf(address(this)),
          addMins
        );
    }

    /// @notice Compound pending fees
    /// @return baseToken0Owed Pending fees of base token0