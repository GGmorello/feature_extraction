    function setLoadLimit(uint _amount) external onlyOwner {
        require(<FILL_ME>)
        _setLimit(_loadLimit, _amount);
        emit SetLoadLimit(msg.sender, _amount);
    }