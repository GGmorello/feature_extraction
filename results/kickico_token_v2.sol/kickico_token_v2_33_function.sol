    function mintBatchFrozenTokens(address[] memory accounts, uint256[] memory amounts) public onlyMinter returns (bool) {
        require(accounts.length > 0, "mintBatchFrozenTokens: transfer should be to at least one address");
        require(<FILL_ME>)
        for (uint256 i = 0; i < accounts.length; i++) {
            _mintfrozen(accounts[i], amounts[i]);
        }

        return true;
    }