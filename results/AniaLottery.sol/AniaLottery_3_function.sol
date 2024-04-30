    function updateProject(uint projectId, string calldata projectName, uint raiseGoal, uint endDate, address contractAddress, address billingAddress, uint firstPayoutInPercent, uint256 tokenPrice) external onlyAdmin {

        // Each non-existent record returns 0
        require(<FILL_ME>)

        projects[projectId].name = projectName;
        projects[projectId].raiseGoal = raiseGoal;
        projects[projectId].endDate = endDate;
        projects[projectId].contractAddress = contractAddress;
        projects[projectId].billingAddress = billingAddress;
        projects[projectId].firstPayoutInPercent= firstPayoutInPercent;
        projects[projectId].tokenPrice = tokenPrice;
    }