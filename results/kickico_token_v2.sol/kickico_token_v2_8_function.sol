    function transfer(address recipient, uint256 amount) public canTransfer returns (bool) {
        require(<FILL_ME>)
        require(_balances[msg.sender] >= amount);
        _transfer(msg.sender, recipient, amount);
        return true;
    }