    function changeTierThree(uint _value) external onlyAdmin {
        require(_value > 0, "Tier value has to be more than 0");
        require(_value < tierOne, "Tier value has to be less than Tier One");
        require(<FILL_ME>)
        tierThree = _value;
    }