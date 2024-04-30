    function transferFrom(address _from, address _receiver, uint256 _amount) public returns (bool) {
        require(_from != address(0));
        require(<FILL_ME>)
        require(_amount <= allowance(_from, msg.sender));
        require(_amount <= getAvailableBalance(_from));
        return ERC20.transferFrom(_from, _receiver, _amount);
    }