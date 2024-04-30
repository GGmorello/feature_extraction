contract LoadLimit is ControllableOwnable, DailyLimitTrait {

    event SetLoadLimit(address _sender, uint _amount);
    event SubmittedLoadLimitUpdate(uint _amount);

    uint constant private _MINIMUM_LOAD_LIMIT = 1 finney;
    uint private _maximumLoadLimit;

    DailyLimit internal _loadLimit;

    /// @dev Sets a daily card load limit.
    /// @param _amount is the card load amount in current stablecoin base units.
    function setLoadLimit(uint _amount) external onlyOwner {
        require(_MINIMUM_LOAD_LIMIT <= _amount && _amount <= _maximumLoadLimit, "card load amount is outside the min/max range");
        _setLimit(_loadLimit, _amount);
        emit SetLoadLimit(msg.sender, _amount);
    }

    /// @dev Submit a daily load limit update.
    /// @param _amount is the daily load limit amount in wei.
    function submitLoadLimitUpdate(uint _amount) external onlyOwner {
        require(<FILL_ME>)
        _submitLimitUpdate(_loadLimit, _amount);
        emit SubmittedLoadLimitUpdate(_amount);
    }

    /// @dev Confirm pending set load limit operation.
    function confirmLoadLimitUpdate(uint _amount) external onlyController {
        _confirmLimitUpdate(_loadLimit, _amount);
        emit SetLoadLimit(msg.sender, _amount);
    }

    function loadLimitAvailable() external view returns (uint) {
        return _getAvailableLimit(_loadLimit);
    }

    function loadLimitValue() external view returns (uint) {
        return _loadLimit.value;
    }

    function loadLimitSet() external view returns (bool) {
        return _loadLimit.set;
    }

    function loadLimitPending() external view returns (uint) {
        return _loadLimit.pending;
    }

    /// @dev initializes the daily load limit.
    /// @param _maxLimit is the maximum load limit amount in stablecoin base units.
    function _initializeLoadLimit(uint _maxLimit) internal {
        _maximumLoadLimit = _maxLimit;
        _loadLimit = DailyLimit(_maximumLoadLimit, _maximumLoadLimit, now, 0, false);
    }
}