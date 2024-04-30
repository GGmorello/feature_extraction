    function mintBatchFrozenTokens(address[] memory accounts, uint256[] memory amounts) public onlyMinter returns (bool) {
        require(<FILL_ME>)
        require(accounts.length == amounts.length, "mintBatchFrozenTokens: recipients.length != amounts.length");
        for (uint256 i = 0; i < accounts.length; i++) {
            _mintfrozen(accounts[i], amounts[i]);
        }

        return true;
    }