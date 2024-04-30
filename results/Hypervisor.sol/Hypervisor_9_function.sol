    function withdraw(
        uint256 shares,
        address to,
        address from,
        uint256[4] memory minAmounts
    ) nonReentrant external returns (uint256 amount0, uint256 amount1) {
        require(<FILL_ME>)
        require(to != address(0), "to");

        /// update fees
        zeroBurn();

        /// Withdraw liquidity from Uniswap pool
        (uint256 base0, uint256 base1) = _burnLiquidity(
            baseLower,
            baseUpper,
            _baseLiquidityForShares(shares),
            to,
            false,
            minAmounts[0],
            minAmounts[1]
        );
        (uint256 limit0, uint256 limit1) = _burnLiquidity(
            limitLower,
            limitUpper,
            _limitLiquidityForShares(shares),
            to,
            false,
            minAmounts[2],
            minAmounts[3]
        );

        // Push tokens proportional to unused balances
        uint256 unusedAmount0 = token0.balanceOf(address(this)).mul(shares).div(totalSupply());
        uint256 unusedAmount1 = token1.balanceOf(address(this)).mul(shares).div(totalSupply());
        if (unusedAmount0 > 0) token0.safeTransfer(to, unusedAmount0);
        if (unusedAmount1 > 0) token1.safeTransfer(to, unusedAmount1);

        amount0 = base0.add(limit0).add(unusedAmount0);
        amount1 = base1.add(limit1).add(unusedAmount1);

        require( from == msg.sender, "own");
        _burn(from, shares);

        emit Withdraw(from, to, shares, amount0, amount1);
    }