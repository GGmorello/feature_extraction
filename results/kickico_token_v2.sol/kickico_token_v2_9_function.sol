    function transfer(address recipient, uint256 amount) public canTransfer returns (bool) {
        require(recipient != address(this), "can't transfer tokens to the contract address");
        require(<FILL_ME>)
        _transfer(msg.sender, recipient, amount);
        return true;
    }