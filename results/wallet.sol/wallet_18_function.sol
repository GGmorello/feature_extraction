    function _setLimit(DailyLimit storage dl, uint _amount) internal {
        // Require that the spend limit has not been set yet.
        require(<FILL_ME>)
        // Modify spend limit based on the provided value.
        _modifyLimit(dl, _amount);
        // Flag the operation as set.
        dl.set = true;
    }