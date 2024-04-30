    function transferFrom(address _from, address _receiver, uint256 _amount) public returns (bool) {
        require(_from != address(0));
        require(_receiver != address(0));
        require(_amount <= allowance(_from, msg.sender));
        require(<FILL_ME>)
        return ERC20.transferFrom(_from, _receiver, _amount);
    }