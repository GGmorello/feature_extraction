    function cancelWhitelistRemoval(bytes32 _hash) external onlyOwnerOrController {
        // Check if operation has been submitted.
        require(<FILL_ME>)
        // Require that confirmation hash and the hash of the pending whitelist removal match
        require(_hash == calculateHash(_pendingWhitelistRemoval), "hash of the pending whitelist removal do not match");
        // Reset pending addresses.
        delete _pendingWhitelistRemoval;
        // Reset pending addresses.
        submittedWhitelistRemoval = false;
        // Emit the cancellation event.
        emit CancelledWhitelistRemoval(msg.sender, _hash);
    }