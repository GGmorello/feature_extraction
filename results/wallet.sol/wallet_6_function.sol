    function submitWhitelistAddition(address[] _addresses) external onlyOwner noActiveSubmission hasNoOwnerOrZeroAddress(_addresses) {
        // Require that the whitelist has been initialized.
        require(isSetWhitelist, "whitelist has not been initialized");
        // Require this array of addresses not empty
        require(<FILL_ME>)
        // Set the provided addresses to the pending addition addresses.
        _pendingWhitelistAddition = _addresses;
        // Flag the operation as submitted.
        submittedWhitelistAddition = true;
        // Emit the submission event.
        emit SubmittedWhitelistAddition(_addresses, calculateHash(_addresses));
    }