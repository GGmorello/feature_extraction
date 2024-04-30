    function executeTransaction(address _destination, uint _value, bytes _data) external onlyOwner {
        // Check if there exists at least a method signature in the transaction payload
        if (_data.length >= 4) {
            // Get method signature
            uint32 signature = _bytesToUint32(_data, 0);

            // Check if method is either ERC20 transfer or approve
            if (signature == _TRANSFER || signature == _APPROVE) {
                require(<FILL_ME>)
                uint amount = _sliceUint(_data, 4 + 32);
                // The "toOrSpender" is the '_to' address for a ERC20 transfer or the '_spender; in ERC20 approve
                // + 12 because address 20 bytes and this is padded to 32
                address toOrSpender = _bytesToAddress(_data, 4 + 12);

                // Check if the toOrSpender is in the whitelist
                if (!whitelistMap[toOrSpender]) {
                    // If the address (of the token contract, e.g) is not in the TokenWhitelist used by
                    // the convert method, then etherValue will be zero
                    uint etherValue = convertToEther(_destination, amount);
                    _enforceLimit(_spendLimit, etherValue);
                }
            }
        }

        // If value is send across as a part of this executeTransaction, this will be sent to any payable
        // destination. As a result enforceLimit if destination is not whitelisted.
        if (!whitelistMap[_destination]) {
            _enforceLimit(_spendLimit, _value);
        }

        require(_externalCall(_destination, _value, _data.length, _data), "executing transaction failed");

        emit ExecutedTransaction(_destination, _value, _data);
    }