    function transfer(address _receiver, uint256 _amount) public returns (bool success) {
        require(<FILL_ME>)
        require(_amount <= getAvailableBalance(msg.sender));
        return ERC20.transfer(_receiver, _amount);
    }