    modifier hasNoOwnerOrZeroAddress(address[] _addresses) {
        for (uint i = 0; i < _addresses.length; i++) {
            require(!_isOwner(_addresses[i]), "provided whitelist contains the owner address");
            require(<FILL_ME>)
        }
        _;
    }