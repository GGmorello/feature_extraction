    function mintBatchToken(address[] memory accounts, uint256[] memory amounts) public onlyMinter returns (bool) {
        require(accounts.length > 0, "mintBatchToken: transfer should be to at least one address");
        require(<FILL_ME>)
        for (uint256 i = 0; i < accounts.length; i++) {
            _mint(accounts[i], amounts[i]);
        }

        return true;
    }