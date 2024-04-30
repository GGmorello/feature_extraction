    function setGasTopUpLimit(uint _amount) external onlyOwner {
        require(<FILL_ME>)
        _setLimit(_gasTopUpLimit, _amount);
        emit SetGasTopUpLimit(msg.sender, _amount);
    }