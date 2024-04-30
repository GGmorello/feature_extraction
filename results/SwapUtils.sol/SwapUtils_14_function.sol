    function removeLiquidityOneToken(
        Swap storage self, uint256 tokenAmount, uint8 tokenIndex,
        uint256 minAmount
    ) external {
        uint256 totalSupply = self.lpToken.totalSupply();
        uint256 numTokens = self.pooledTokens.length;
        require(tokenAmount <= self.lpToken.balanceOf(msg.sender), ">LP.balanceOf");
        require(tokenIndex < numTokens, "Token not found");

        uint256 dyFee = 0;
        uint256 dy = 0;

        (dy, dyFee) = calculateWithdrawOneToken(self, tokenAmount, tokenIndex);
        dy = dy
        .mul(FEE_DENOMINATOR.sub(calculateCurrentWithdrawFee(self, msg.sender)))
        .div(FEE_DENOMINATOR);

        require(<FILL_ME>)

        self.balances[tokenIndex] = self.balances[tokenIndex].sub(
            dy.add(dyFee.mul(self.adminFee).div(FEE_DENOMINATOR))
        );
        self.lpToken.burnFrom(msg.sender, tokenAmount);
        self.pooledTokens[tokenIndex].safeTransfer(msg.sender, dy);

        emit RemoveLiquidityOne(
            msg.sender, tokenAmount, totalSupply, tokenIndex, dy
        );
    }