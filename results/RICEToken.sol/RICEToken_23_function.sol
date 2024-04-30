    function transfer(address _receiver, uint256 _amount) public returns (bool success) {
        require(_receiver != address(0));
        require(<FILL_ME>)
        return ERC20.transfer(_receiver, _amount);
    }