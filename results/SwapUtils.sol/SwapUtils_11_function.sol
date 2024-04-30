    function removeLiquidity(
        Swap storage self, uint256 amount, uint256[] calldata minAmounts
    ) external {
        require(amount <= self.lpToken.balanceOf(msg.sender), ">LP.balanceOf");
        require(
            minAmounts.length == self.pooledTokens.length,
            "Min amounts should correspond to pooled tokens"
        );

        uint256 adjustedAmount = amount
            .mul(FEE_DENOMINATOR.sub(calculateCurrentWithdrawFee(self, msg.sender)))
            .div(FEE_DENOMINATOR);

        uint256[] memory amounts = calculateRebalanceAmounts(self, adjustedAmount);

        for (uint i = 0; i < amounts.length; i++) {
            require(<FILL_ME>)

            self.balances[i] = self.balances[i].sub(amounts[i]);
        }

        self.lpToken.burnFrom(msg.sender, amount);

        for (uint i = 0; i < self.pooledTokens.length; i++) {
            self.pooledTokens[i].safeTransfer(msg.sender, amounts[i]);
        }

        emit RemoveLiquidity(
            msg.sender, amounts, self.lpToken.totalSupply()
        );
    }

    /**