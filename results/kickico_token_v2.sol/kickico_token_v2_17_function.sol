    function _approve(address _owner, address spender, uint256 value) internal {
        require(<FILL_ME>)
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[_owner][spender] = value;
        emit Approval(_owner, spender, value);
    }