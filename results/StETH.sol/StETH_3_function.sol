    function _approve(address _owner, address _spender, uint256 _amount) internal whenNotStopped {
        require(_owner != address(0), "APPROVE_FROM_ZERO_ADDRESS");
        require(<FILL_ME>)

        allowances[_owner][_spender] = _amount;
        emit Approval(_owner, _spender, _amount);
    }