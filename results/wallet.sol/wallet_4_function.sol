    function setWhitelist(address[] _addresses) external onlyOwner hasNoOwnerOrZeroAddress(_addresses) {
        // Require that the whitelist has not been initialized.
        require(<FILL_ME>)
        // Add each of the provided addresses to the whitelist.
        for (uint i = 0; i < _addresses.length; i++) {
            // adds to the whitelist mapping
            whitelistMap[_addresses[i]] = true;
            // adds to the whitelist array
            whitelistArray.push(_addresses[i]);
        }
        isSetWhitelist = true;
        // Emit the addition event.
        emit AddedToWhitelist(msg.sender, _addresses);
    }