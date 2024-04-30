    function confirmWhitelistAddition(bytes32 _hash) external onlyController {
        // Require that the whitelist addition has been submitted.
        require(submittedWhitelistAddition, "whitelist addition has not been submitted");
        // Require that confirmation hash and the hash of the pending whitelist addition match
        require(<FILL_ME>)
        // Whitelist pending addresses.
        for (uint i = 0; i < _pendingWhitelistAddition.length; i++) {
            // check if it doesn't exist already.
            if (!whitelistMap[_pendingWhitelistAddition[i]]) {
                 // add to the Map and the Array
                whitelistMap[_pendingWhitelistAddition[i]] = true;
                whitelistArray.push(_pendingWhitelistAddition[i]);
            }
        }
        // Emit the addition event.
        emit AddedToWhitelist(msg.sender, _pendingWhitelistAddition);
        // Reset pending addresses.
        delete _pendingWhitelistAddition;
        // Reset the submission flag.
        submittedWhitelistAddition = false;
    }