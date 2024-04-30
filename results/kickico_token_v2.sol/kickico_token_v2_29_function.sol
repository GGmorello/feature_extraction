    function _burnFrozen(address account, uint256 amount) internal {
        require(<FILL_ME>)

        _totalSupply = _totalSupply.sub(amount);
        _frozen_sub(account, amount);

        emit Transfer(account, address(this), amount);
    }