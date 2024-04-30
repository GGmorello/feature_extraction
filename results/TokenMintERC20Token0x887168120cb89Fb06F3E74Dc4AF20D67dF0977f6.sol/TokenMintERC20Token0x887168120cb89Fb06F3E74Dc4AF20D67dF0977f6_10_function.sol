    function _approve(address owner, address spender, uint256 value) internal {

        require(owner != address(0), "ERC20: approve from the zero address");

        require(<FILL_ME>)



        _allowances[owner][spender] = value;

        emit Approval(owner, spender, value);

    }