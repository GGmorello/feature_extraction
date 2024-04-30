    function increase_unlock_time(uint _tokenId, uint _lock_duration) external nonreentrant {
        assert(_isApprovedOrOwner(msg.sender, _tokenId));

        LockedBalance memory _locked = locked[_tokenId];
        uint unlock_time = (block.timestamp + _lock_duration) / WEEK * WEEK; // Locktime is rounded down to weeks

        require(_locked.end > block.timestamp, 'Lock expired');
        require(_locked.amount > 0, 'Nothing is locked');
        require(unlock_time > _locked.end, 'Can only increase lock duration');
        require(<FILL_ME>)

        _deposit_for(_tokenId, 0, unlock_time, _locked, DepositType.INCREASE_UNLOCK_TIME);
    }