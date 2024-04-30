    function transferFrozenToken(address from, address to, uint256 amount) public onlyOwner returns (bool) {
        require(<FILL_ME>)
        require(to != address(0), "ERC20: transfer to the zero address");

        _frozen_sub(from, amount);
        _frozen_add(to, amount);

        emit FrozenTransfer(from, to, amount);
        emit Transfer(from, to, amount);

        return true;
    }