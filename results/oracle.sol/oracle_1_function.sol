    function __callback(bytes32 _queryID, string _result, bytes _proof) public {
        // Require that the caller is the Oraclize contract.
        require(msg.sender == oraclize_cbAddress(), "sender is not oraclize");
        // Use the query ID to find the matching token address.
        address token = _queryToToken[_queryID];
        require(<FILL_ME>)
        // Get the corresponding token object.
        ( , , , bool available, , , uint256 lastUpdate) = _getTokenInfo(token);
        require(available, "token must be available");

        bool valid;
        uint timestamp;
        (valid, timestamp) = _verifyProof(_result, _proof, cryptoCompareAPIPublicKey, lastUpdate);

        // Require that the proof is valid.
        if (valid) {
            // Parse the JSON result to get the rate in wei.
            uint256 parsedRate = _parseIntScientificWei(parseRate(_result));
            // Set the update time of the token rate.
            uint256 parsedLastUpdate = timestamp;
            // Remove query from the list.
            delete _queryToToken[_queryID];

            _updateTokenRate(token, parsedRate, parsedLastUpdate);
        }
    }