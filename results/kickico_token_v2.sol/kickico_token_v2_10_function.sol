    function transferFrom(address sender, address recipient, uint256 amount) public canTransfer returns (bool) {
        require(<FILL_ME>)

        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount));
        return true;
    }