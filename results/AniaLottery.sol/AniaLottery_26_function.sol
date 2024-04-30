    function changeTierTwoTicketValue(uint _value) external onlyAdmin {
        require(_value > 0, "Tier Ticket value has to be more than 0");
        require(_value < tierOneTicketValue, "Tier Ticket value has to be less than Tier One");
        require(<FILL_ME>)
        tierTwoTicketValue = _value;
    }