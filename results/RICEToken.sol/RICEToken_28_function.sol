    function transferWithLock(address _receiver, uint256 _amount, uint256 _releaseDate) public returns (bool success) {
        require(<FILL_ME>)
        ERC20._transfer(msg.sender,_receiver,_amount);

        if (lockList[_receiver].length==0) lockedAddressList.push(_receiver);

        LockTime memory item = LockTime({amount:_amount, releaseDate:_releaseDate});
        lockList[_receiver].push(item);

        return true;
    }