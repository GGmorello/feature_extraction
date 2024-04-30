    function removeLiquidityImbalance(
        Swap storage self, uint256[] memory amounts, uint256 maxBurnAmount
    ) public {
        require(<FILL_ME>)

        require(maxBurnAmount <= self.lpToken.balanceOf(msg.sender) && maxBurnAmount != 0, ">LP.balanceOf");

        uint256 tokenSupply = self.lpToken.totalSupply();
        uint256 _fee = feePerToken(self);

        uint256[] memory balances1 = self.balances;

        uint256 D0 = getD(_xp(self), getA(self));
        for (uint i = 0; i < self.pooledTokens.length; i++) {
            balances1[i] = balances1[i].sub(amounts[i]);
        }
        uint256 D1 = getD(_xp(self, balances1), getA(self));
        uint256[] memory fees = new uint256[](self.pooledTokens.length);

        for (uint i = 0; i < self.pooledTokens.length; i++) {
            uint256 idealBalance = D1.mul(self.balances[i]).div(D0);
            uint256 difference = idealBalance.difference(balances1[i]);
            fees[i] = _fee.mul(difference).div(FEE_DENOMINATOR);
            self.balances[i] = balances1[i].sub(fees[i].mul(self.adminFee).div(
                FEE_DENOMINATOR));
            balances1[i] = balances1[i].sub(fees[i]);
        }

        uint256 D2 = getD(_xp(self, balances1), getA(self));

        uint256 tokenAmount = D0.sub(D2).mul(tokenSupply).div(D0).add(1);
        tokenAmount = tokenAmount
            .mul(FEE_DENOMINATOR)
            .div(FEE_DENOMINATOR.sub(calculateCurrentWithdrawFee(self, msg.sender)));

        require(
            tokenAmount <= maxBurnAmount,
            "More expensive than the max burn amount"
        );

        self.lpToken.burnFrom(msg.sender, tokenAmount);

        for (uint i = 0; i < self.pooledTokens.length; i++) {
            self.pooledTokens[i].safeTransfer(msg.sender, amounts[i]);
        }

        emit RemoveLiquidityImbalance(
            msg.sender, amounts, fees, D1, tokenSupply.sub(tokenAmount));
    }

    /**