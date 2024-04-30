    function _mint(address account, uint256 amount) internal {

        require(<FILL_ME>)



        _totalSupply = _totalSupply.add(amount);

        _balances[account] = _balances[account].add(amount);

        emit Transfer(address(0), account, amount);

    }