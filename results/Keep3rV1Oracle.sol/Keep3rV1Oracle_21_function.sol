    modifier upkeep() {
        uint _gasUsed = gasleft();
        require(<FILL_ME>)
        _;
        uint _received = KP3R.KPRH().getQuoteLimit(_gasUsed.sub(gasleft()));
        KP3R.receipt(address(KP3R), address(this), _received);
        _received = _swap(_received);
        msg.sender.transfer(_received);
    }