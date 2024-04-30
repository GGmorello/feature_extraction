    function changeTierOne(uint _value) external onlyAdmin {
        require(_value > 0, "Tier value has to be more than 0");
        require(_value > tierTwo, "Tier value has to be more than Tier Two");
        require(<FILL_ME>)
        tierOne = _value;
    }