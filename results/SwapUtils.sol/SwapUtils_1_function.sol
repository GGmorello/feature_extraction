    function _xp(
        uint256[] memory _balances,
        uint256[] memory precisionMultipliers
    ) internal pure returns (uint256[] memory) {
        uint256 numTokens = _balances.length;
        require(<FILL_ME>)

        uint256[] memory xp = _balances;
        for (uint i = 0; i < numTokens; i++) {
            xp[i] = xp[i].mul(precisionMultipliers[i]);
        }
        return xp;
    }

    /**