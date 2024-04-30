    function _create_lock(uint _value, uint _lock_duration, address _to) internal returns (uint) {
        uint unlock_time = (block.timestamp + _lock_duration) / WEEK * WEEK; // Locktime is rounded down to weeks

        require(_value > 0); // dev: need non-zero value
        require(<FILL_ME>)
        require(unlock_time <= block.timestamp + MAXTIME, 'Voting lock can be 4 years max');

        ++tokenId;
        uint _tokenId = tokenId;
        _mint(_to, _tokenId);

        _deposit_for(_tokenId, _value, unlock_time, locked[_tokenId], DepositType.CREATE_LOCK_TYPE);
        return _tokenId;
    }