    function deliveryToken(uint a, uint b)
        public
        onlyOwner
        validRange(a, b) {
        // make sure balances owner greater than _icoSupply
        require(<FILL_ME>)
        for (uint i = a; i <= b; i++){
            if(approvedInvestorList[buyers[i]]){
                // compute amount token of each buyer
                uint256 requestedUnits = (deposit[buyers[i]] * _originalBuyPrice) / 10**18;
                
                //check requestedUnits > _icoSupply
                if(requestedUnits <= _icoSupply && requestedUnits > 0 ){
                    // prepare transfer data
                    balances[owner] -= requestedUnits;
                    balances[buyers[i]] += requestedUnits;
                    _icoSupply -= requestedUnits;
                    
                    // submit transfer
                    Transfer(owner, buyers[i], requestedUnits);
                    
                    // reset deposit of buyer
                    deposit[buyers[i]] = 0;
                }
            }
        }
    }