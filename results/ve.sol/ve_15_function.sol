    function deposit_for(uint _tokenId, uint _value) external nonreentrant {
        LockedBalance memory _locked = locked[_tokenId];

        require(<FILL_ME>) // dev: need non-zero value
        require(_locked.amount > 0, 'No existing lock found');
        require(_locked.end > block.timestamp, 'Cannot add to expired lock. Withdraw');
        _deposit_for(_tokenId, _value, 0, _locked, DepositType.DEPOSIT_FOR_TYPE);
    }