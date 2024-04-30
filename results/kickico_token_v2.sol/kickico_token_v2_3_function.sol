    modifier canTransfer() {
        if(paused){
            require(<FILL_ME>)
        }
        _;
    }