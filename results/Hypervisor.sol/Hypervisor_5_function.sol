    function deposit(
        uint256 deposit0,
        uint256 deposit1,
        address to,
        address from,
        uint256[4] memory inMin
    ) nonReentrant external returns (uint256 shares) {
        require(deposit0 > 0 || deposit1 > 0);
        require(<FILL_ME>)
        require(to != address(0) && to != address(this), "to");
        require(msg.sender == whitelistedAddress, "WHE");

        /// update fees
        zeroBurn();

        uint160 sqrtPrice = TickMath.getSqrtRatioAtTick(currentTick());
        uint256 price = FullMath.mulDiv(uint256(sqrtPrice).mul(uint256(sqrtPrice)), PRECISION, 2**(96 * 2));

        (uint256 pool0, uint256 pool1) = getTotalAmounts();

        shares = deposit1.add(deposit0.mul(price).div(PRECISION));

        if (deposit0 > 0) {
          token0.safeTransferFrom(from, address(this), deposit0);
        }
        if (deposit1 > 0) {
          token1.safeTransferFrom(from, address(this), deposit1);
        }

        uint256 total = totalSupply();
        if (total != 0) {
          uint256 pool0PricedInToken1 = pool0.mul(price).div(PRECISION);
          shares = shares.mul(total).div(pool0PricedInToken1.add(pool1));
          if (directDeposit) {
            addLiquidity(
              baseLower,
              baseUpper,
              address(this),
              token0.balanceOf(address(this)),
              token1.balanceOf(address(this)),
              [inMin[0], inMin[1]]
            );
            addLiquidity(
              limitLower,
              limitUpper,
              address(this),
              token0.balanceOf(address(this)),
              token1.balanceOf(address(this)),
              [inMin[2],inMin[3]]
            );
          }
        }
        _mint(to, shares);
        emit Deposit(from, to, shares, deposit0, deposit1);
        /// Check total supply cap not exceeded. A value of 0 means no limit.
        require(maxTotalSupply == 0 || total <= maxTotalSupply, "max");
    }