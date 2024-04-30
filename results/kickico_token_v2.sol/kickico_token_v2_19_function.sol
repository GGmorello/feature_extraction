    function mintBatchToken(address[] memory accounts, uint256[] memory amounts) public onlyMinter returns (bool) {
        require(<FILL_ME>)
        require(accounts.length == amounts.length, "mintBatchToken: recipients.length != amounts.length");
        for (uint256 i = 0; i < accounts.length; i++) {
            _mint(accounts[i], amounts[i]);
        }

        return true;
    }