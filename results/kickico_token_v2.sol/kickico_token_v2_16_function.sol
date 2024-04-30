    function _burn(address account, uint256 value) internal {
        require(<FILL_ME>)

        _totalSupply = _totalSupply.sub(value);
        _balances[account] = _balances[account].sub(value);
        emit Transfer(account, address(this), value);
    }