    function _transferShares(address _sender, address _recipient, uint256 _sharesAmount) internal whenNotStopped {
        require(_sender != address(0), "TRANSFER_FROM_THE_ZERO_ADDRESS");
        require(<FILL_ME>)

        uint256 currentSenderShares = shares[_sender];
        require(_sharesAmount <= currentSenderShares, "TRANSFER_AMOUNT_EXCEEDS_BALANCE");

        shares[_sender] = currentSenderShares.sub(_sharesAmount);
        shares[_recipient] = shares[_recipient].add(_sharesAmount);
    }