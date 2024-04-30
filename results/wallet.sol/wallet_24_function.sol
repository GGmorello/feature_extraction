    function submitLoadLimitUpdate(uint _amount) external onlyOwner {
        require(<FILL_ME>)
        _submitLimitUpdate(_loadLimit, _amount);
        emit SubmittedLoadLimitUpdate(_amount);
    }