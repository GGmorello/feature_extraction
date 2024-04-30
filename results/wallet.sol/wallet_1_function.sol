    modifier hasNoOwnerOrZeroAddress(address[] _addresses) {
        for (uint i = 0; i < _addresses.length; i++) {
            require(<FILL_ME>)
            require(_addresses[i] != address(0), "provided whitelist contains the zero address");
        }
        _;
    }