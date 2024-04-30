    function _approve(address _owner, address _spender, uint256 _amount) internal whenNotStopped {
        require(<FILL_ME>)
        require(_spender != address(0), "APPROVE_TO_ZERO_ADDRESS");

        allowances[_owner][_spender] = _amount;
        emit Approval(_owner, _spender, _amount);
    }