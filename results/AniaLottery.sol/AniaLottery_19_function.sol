    function changeTierThree(uint _value) external onlyAdmin {
        require(_value > 0, "Tier value has to be more than 0");
        require(<FILL_ME>)
        require(_value < tierTwo, "Tier value has to be less than Tier Two");
        tierThree = _value;
    }