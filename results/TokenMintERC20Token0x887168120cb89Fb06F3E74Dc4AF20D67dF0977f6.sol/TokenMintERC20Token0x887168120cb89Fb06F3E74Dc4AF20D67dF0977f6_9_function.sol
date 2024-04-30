    function _approve(address owner, address spender, uint256 value) internal {

        require(<FILL_ME>)

        require(spender != address(0), "ERC20: approve to the zero address");



        _allowances[owner][spender] = value;

        emit Approval(owner, spender, value);

    }