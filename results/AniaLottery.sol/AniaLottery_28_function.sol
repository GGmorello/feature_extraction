    function changeTierThreeTicketValue(uint _value) external onlyAdmin {
        require(_value > 0, "Tier Ticket value has to be more than 0");
        require(<FILL_ME>)
        require(_value < tierTwoTicketValue, "Tier Ticket value has to be less than Tier Two");
        tierThreeTicketValue = _value;
    }