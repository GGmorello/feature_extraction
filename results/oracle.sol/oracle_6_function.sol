    function _updateTokenRatesList(uint _gasLimit, address[] _tokenList) private {
        // Check if there are any existing tokens.
        if (_tokenList.length == 0) {
            // Emit a query failure event.
            emit FailedUpdateRequest("empty token list");
        // Check if the contract has enough Ether to pay for the query.
        } else if (oraclize_getPrice("URL") * _tokenList.length > address(this).balance) {
            // Emit a query failure event.
            emit FailedUpdateRequest("insufficient balance");
        } else {
            // Set up the cryptocompare API query strings.
            strings.slice memory apiPrefix = "https://min-api.cryptocompare.com/data/price?fsym=".toSlice();
            strings.slice memory apiSuffix = "&tsyms=ETH&sign=true".toSlice();

            // Create a new oraclize query for each supported token.
            for (uint i = 0; i < _tokenList.length; i++) {
                //token must exist, revert if it doesn't
                (string memory tokenSymbol, , , bool available , , , ) = _getTokenInfo(_tokenList[i]);
                require(<FILL_ME>)
                // Store the token symbol used in the query.
                strings.slice memory symbol = tokenSymbol.toSlice();
                // Create a new oraclize query from the component strings.
                bytes32 queryID = oraclize_query("URL", apiPrefix.concat(symbol).toSlice().concat(apiSuffix), _gasLimit);
                // Store the query ID together with the associated token address.
                _queryToToken[queryID] = _tokenList[i];
                // Emit the query success event.
                emit RequestedUpdate(symbol.toString());
            }
        }
    }