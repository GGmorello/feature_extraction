contract GasTopUpLimit is ControllableOwnable, DailyLimitTrait {

    event SetGasTopUpLimit(address _sender, uint _amount);
    event SubmittedGasTopUpLimitUpdate(uint _amount);

    uint constant private _MINIMUM_GAS_TOPUP_LIMIT = 1 finney;
    uint constant private _MAXIMUM_GAS_TOPUP_LIMIT = 500 finney;

    DailyLimit internal _gasTopUpLimit;

    /// @dev Constructor initializes the daily gas topup limit in wei.
    constructor() internal {
        _gasTopUpLimit = DailyLimit(_MAXIMUM_GAS_TOPUP_LIMIT, _MAXIMUM_GAS_TOPUP_LIMIT, now, 0, false);
    }

    /// @dev Sets the daily gas top up limit.
    /// @param _amount is the gas top up amount in wei.
    function setGasTopUpLimit(uint _amount) external onlyOwner {
        require(_MINIMUM_GAS_TOPUP_LIMIT <= _amount && _amount <= _MAXIMUM_GAS_TOPUP_LIMIT, "gas top up amount is outside the min/max range");
        _setLimit(_gasTopUpLimit, _amount);
        emit SetGasTopUpLimit(msg.sender, _amount);
    }

    /// @dev Submit a daily gas top up limit update.
    /// @param _amount is the daily top up gas limit amount in wei.
    function submitGasTopUpLimitUpdate(uint _amount) external onlyOwner {
        require(<FILL_ME>)
        _submitLimitUpdate(_gasTopUpLimit, _amount);
        emit SubmittedGasTopUpLimitUpdate(_amount);
    }

    /// @dev Confirm pending set top up gas limit operation.
    function confirmGasTopUpLimitUpdate(uint _amount) external onlyController {
        _confirmLimitUpdate(_gasTopUpLimit, _amount);
        emit SetGasTopUpLimit(msg.sender, _amount);
    }

    function gasTopUpLimitAvailable() external view returns (uint) {
        return _getAvailableLimit(_gasTopUpLimit);
    }

    function gasTopUpLimitValue() external view returns (uint) {
        return _gasTopUpLimit.value;
    }

    function gasTopUpLimitSet() external view returns (bool) {
        return _gasTopUpLimit.set;
    }

    function gasTopUpLimitPending() external view returns (uint) {
        return _gasTopUpLimit.pending;
    }
}