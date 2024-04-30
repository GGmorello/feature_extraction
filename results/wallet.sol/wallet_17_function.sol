    function _enforceLimit(DailyLimit storage dl, uint _amount) internal {
        // Account for the spend limit daily reset.
        _updateAvailableLimit(dl);
        require(<FILL_ME>)
        dl.available = dl.available.sub(_amount);
    }