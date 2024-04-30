    function transferFrom(address _sender, address _recipient, uint256 _amount) public returns (bool) {
        uint256 currentAllowance = allowances[_sender][msg.sender];
        require(<FILL_ME>)

        _transfer(_sender, _recipient, _amount);
        _approve(_sender, msg.sender, currentAllowance.sub(_amount));
        return true;
    }