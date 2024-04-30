    function addLiquidity(Swap storage self, uint256[] calldata amounts, uint256 minToMint)
        external {
        require(<FILL_ME>)


        uint256[] memory fees = new uint256[](self.pooledTokens.length);

        // current state
        uint256 D0 = 0;
        if (self.lpToken.totalSupply() > 0) {
            D0 = getD(self);
        }
        uint256[] memory newBalances = self.balances;

        for (uint i = 0; i < self.pooledTokens.length; i++) {
            require(
                self.lpToken.totalSupply() > 0 || amounts[i] > 0,
                "If token supply is zero, must supply all tokens in pool"
            );
            newBalances[i] = self.balances[i].add(amounts[i]);
        }

        // invariant after change
        uint256 D1 = getD(_xp(self, newBalances), getA(self));
        require(D1 > D0, "D should increase after additional liquidity");

        // updated to reflect fees and calculate the user's LP tokens
        uint256 D2 = D1;
        if (self.lpToken.totalSupply() > 0) {
            for (uint i = 0; i < self.pooledTokens.length; i++) {
                uint256 idealBalance = D1.mul(self.balances[i]).div(D0);
                fees[i] = feePerToken(self).mul(
                    idealBalance.difference(newBalances[i])).div(FEE_DENOMINATOR);
                self.balances[i] = newBalances[i].sub(
                    fees[i].mul(self.adminFee).div(FEE_DENOMINATOR));
                newBalances[i] = newBalances[i].sub(fees[i]);
            }
            D2 = getD(_xp(self, newBalances), getA(self));
        } else {
            // the initial depositor doesn't pay fees
            self.balances = newBalances;
        }

        uint256 toMint = 0;
        if (self.lpToken.totalSupply() == 0) {
            toMint = D1;
        } else {
            toMint = D2.sub(D0).mul(self.lpToken.totalSupply()).div(D0);
        }

        require(toMint >= minToMint, "Couldn't mint min requested LP tokens");

        for (uint i = 0; i < self.pooledTokens.length; i++) {
            if (amounts[i] > 0) {
                self.pooledTokens[i].safeTransferFrom(
                    msg.sender, address(this), amounts[i]);
            }
        }

        updateUserWithdrawFee(self, msg.sender, toMint);
        // mint the user's LP tokens
        self.lpToken.mint(msg.sender, toMint);

        emit AddLiquidity(
            msg.sender, amounts, fees, D1, self.lpToken.totalSupply()
        );
    }

    /**