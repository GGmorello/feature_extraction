    function _burnShares(address _account, uint256 _sharesAmount) internal whenNotStopped returns (uint256 newTotalShares) {
        require(_account != address(0), "BURN_FROM_THE_ZERO_ADDRESS");

        uint256 accountShares = shares[_account];
        require(<FILL_ME>)

        newTotalShares = _getTotalShares().sub(_sharesAmount);
        TOTAL_SHARES_POSITION.setStorageUint256(newTotalShares);

        shares[_account] = accountShares.sub(_sharesAmount);

        // Notice: we're not emitting a Transfer event to the zero address here since shares burn
        // works by redistributing the amount of tokens corresponding to the burned shares between
        // all other token holders. The total supply of the token doesn't change as the result.
        // This is equivalent to performing a send from `address` to each other token holder address,
        // but we cannot reflect this as it would require sending an unbounded number of events.
    }