    function submitWhitelistRemoval(address[] _addresses) external onlyOwner noActiveSubmission {
        // Require that the whitelist has been initialized.
        require(<FILL_ME>)
        // Require that the array of addresses is not empty
        require(_addresses.length > 0, "pending whitelist removal is empty");
        // Add the provided addresses to the pending addition list.
        _pendingWhitelistRemoval = _addresses;
        // Flag the operation as submitted.
        submittedWhitelistRemoval = true;
        // Emit the submission event.
        emit SubmittedWhitelistRemoval(_addresses, calculateHash(_addresses));
    }