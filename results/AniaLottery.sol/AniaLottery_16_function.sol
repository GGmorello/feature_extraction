    function changeTierTwo(uint _value) external onlyAdmin {
        require(_value > 0, "Tier value has to be more than 0");
        require(<FILL_ME>)
        require(_value > tierThree, "Tier value has to be more than Tier Three");
        tierTwo = _value;
    }