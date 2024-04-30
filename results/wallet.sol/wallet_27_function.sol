    function transfer(address _to, address _asset, uint _amount) external onlyOwner isNotZero(_amount) {
        // Checks if the _to address is not the zero-address
        require(<FILL_ME>)

        // If address is not whitelisted, take daily limit into account.
        if (!whitelistMap[_to]) {
            //initialize ether value in case the asset is ETH
            uint etherValue = _amount;
            // Convert token amount to ether value if asset is an ERC20 token.
            if (_asset != address(0)) {
                etherValue = convertToEther(_asset, _amount);
            }
            // Check against the daily spent limit and update accordingly
            // Check against the daily spent limit and update accordingly, require that the value is under remaining limit.
            _enforceLimit(_spendLimit, etherValue);
        }
        // Transfer token or ether based on the provided address.
        if (_asset != address(0)) {
            require(ERC20(_asset).transfer(_to, _amount), "ERC20 token transfer was unsuccessful");
        } else {
            _to.transfer(_amount);
        }
        // Emit the transfer event.
        emit Transferred(_to, _asset, _amount);
    }