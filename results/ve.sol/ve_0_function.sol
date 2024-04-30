    modifier nonreentrant() {
        require(<FILL_ME>)
        _entered_state = _entered;
        _;
        _entered_state = _not_entered;
    }