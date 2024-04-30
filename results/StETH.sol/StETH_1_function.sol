    function decreaseAllowance(address _spender, uint256 _subtractedValue) public returns (bool) {
        uint256 currentAllowance = allowances[msg.sender][_spender];
        require(<FILL_ME>)
        _approve(msg.sender, _spender, currentAllowance.sub(_subtractedValue));
        return true;
    }