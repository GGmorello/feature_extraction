    function _approve(address _owner, address spender, uint256 value) internal {
        require(_owner != address(0), "ERC20: approve from the zero address");
        require(<FILL_ME>)

        _allowances[_owner][spender] = value;
        emit Approval(_owner, spender, value);
    }