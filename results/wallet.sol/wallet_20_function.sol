    function _confirmLimitUpdate(DailyLimit storage dl, uint _amount) internal {
        // Require that pending and confirmed spend limit are the same
        require(<FILL_ME>)
        // Modify spend limit based on the pending value.
        _modifyLimit(dl, dl.pending);
    }