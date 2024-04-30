    function cancelWhitelistRemoval(bytes32 _hash) external onlyOwnerOrController {
        // Check if operation has been submitted.
        require(submittedWhitelistRemoval, "whitelist removal has not been submitted");
        // Require that confirmation hash and the hash of the pending whitelist removal match
        require(<FILL_ME>)
        // Reset pending addresses.
        delete _pendingWhitelistRemoval;
        // Reset pending addresses.
        submittedWhitelistRemoval = false;
        // Emit the cancellation event.
        emit CancelledWhitelistRemoval(msg.sender, _hash);
    }