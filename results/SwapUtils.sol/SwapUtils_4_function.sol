    function swap(
        Swap storage self, uint8 tokenIndexFrom, uint8 tokenIndexTo, uint256 dx,
        uint256 minDy
    ) external {
        (uint256 dy, uint256 dyFee) = _calculateSwap(self, tokenIndexFrom, tokenIndexTo, dx);
        require(<FILL_ME>)

        uint256 dyAdminFee = dyFee.mul(self.adminFee).div(FEE_DENOMINATOR).div(self.tokenPrecisionMultipliers[tokenIndexTo]);

        self.balances[tokenIndexFrom] = self.balances[tokenIndexFrom].add(dx);
        self.balances[tokenIndexTo] = self.balances[tokenIndexTo].sub(dy).sub(dyAdminFee);

        self.pooledTokens[tokenIndexFrom].safeTransferFrom(
            msg.sender, address(this), dx);
        self.pooledTokens[tokenIndexTo].safeTransfer(msg.sender, dy);

        emit TokenSwap(msg.sender, dx, dy, tokenIndexFrom, tokenIndexTo);
    }