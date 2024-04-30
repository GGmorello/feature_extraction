    function changeRequirement(uint _required)
        public
        onlyWallet
        validRequirement(owners.length, _required)
    {
        require(<FILL_ME>)
        RequirementChange(_required);
    }