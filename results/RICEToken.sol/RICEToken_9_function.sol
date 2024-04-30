    function _approve(address owner, address spender, uint256 amount) internal {
        require(<FILL_ME>)
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }