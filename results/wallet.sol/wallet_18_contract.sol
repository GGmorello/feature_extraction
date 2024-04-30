contract DailyLimitTrait {
    using SafeMath for uint256;

    struct DailyLimit {
        uint value;
        uint available;
        uint limitDay;
        uint pending;
        bool set;
    }

    /// @dev Returns the available daily balance - accounts for daily limit reset.
    /// @return amount of available to spend within the current day in base units.
    function _getAvailableLimit(DailyLimit storage dl) internal view returns (uint) {
        if (now > dl.limitDay + 24 hours) {
            return dl.value;
        } else {
            return dl.available;
        }
    }

    /// @dev Use up amount within the daily limit. Will fail if amount is larger than daily limit.
    function _enforceLimit(DailyLimit storage dl, uint _amount) internal {
        // Account for the spend limit daily reset.
        _updateAvailableLimit(dl);
        require(dl.available >= _amount, "available has to be greater or equal to use amount");
        dl.available = dl.available.sub(_amount);
    }

    /// @dev Set the daily limit.
    /// @param _amount is the daily limit amount in base units.
    function _setLimit(DailyLimit storage dl, uint _amount) internal {
        // Require that the spend limit has not been set yet.
        require(<FILL_ME>)
        // Modify spend limit based on the provided value.
        _modifyLimit(dl, _amount);
        // Flag the operation as set.
        dl.set = true;
    }

    /// @dev Submit a daily limit update, needs to be confirmed.
    /// @param _amount is the daily limit amount in base units.
    function _submitLimitUpdate(DailyLimit storage dl, uint _amount) internal {
        // Require that the spend limit has been set.
        require(dl.set, "limit has not been set");
        // Assign the provided amount to pending daily limit.
        dl.pending = _amount;
    }

    /// @dev Confirm pending set daily limit operation.
    function _confirmLimitUpdate(DailyLimit storage dl, uint _amount) internal {
        // Require that pending and confirmed spend limit are the same
        require(dl.pending == _amount, "confirmed and submitted limits dont match");
        // Modify spend limit based on the pending value.
        _modifyLimit(dl, dl.pending);
    }

    /// @dev Update available spend limit based on the daily reset.
    function _updateAvailableLimit(DailyLimit storage dl) private {
        if (now > dl.limitDay.add(24 hours)) {
            // Advance the current day by how many days have passed.
            uint extraDays = now.sub(dl.limitDay).div(24 hours);
            dl.limitDay = dl.limitDay.add(extraDays.mul(24 hours));
            // Set the available limit to the current spend limit.
            dl.available = dl.value;
        }
    }

    /// @dev Modify the spend limit and spend available based on the provided value.
    /// @dev _amount is the daily limit amount in wei.
    function _modifyLimit(DailyLimit storage dl, uint _amount) private {
        // Account for the spend limit daily reset.
        _updateAvailableLimit(dl);
        // Set the daily limit to the provided amount.
        dl.value = _amount;
        // Lower the available limit if it's higher than the new daily limit.
        if (dl.available > dl.value) {
            dl.available = dl.value;
        }
    }
}