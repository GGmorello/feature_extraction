    function submitGasTopUpLimitUpdate(uint _amount) external onlyOwner {
        require(<FILL_ME>)
        _submitLimitUpdate(_gasTopUpLimit, _amount);
        emit SubmittedGasTopUpLimitUpdate(_amount);
    }