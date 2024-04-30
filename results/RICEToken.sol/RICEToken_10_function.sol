    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(<FILL_ME>)

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }