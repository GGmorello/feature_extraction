    function changeTierOneTicketValue(uint _value) external onlyAdmin {
        require(_value > 0, "Tier Ticket value has to be more than 0");
        require(_value > tierTwoTicketValue, "Tier Ticket value has to be more than Tier Two");
        require(<FILL_ME>)
        tierOneTicketValue = _value;
    }