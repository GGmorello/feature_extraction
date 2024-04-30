    function createProject(uint projectId, string calldata projectName, uint raiseGoal, uint endDate, address contractAddress, address billingAddress, uint firstPayoutInPercent, uint256 tokenPrice) external onlyAdmin {
        require(<FILL_ME>)

        Project memory newProject = Project(projectId, projectName, raiseGoal, endDate, contractAddress, billingAddress, firstPayoutInPercent, tokenPrice, false);

        projects[projectId] = newProject;
    }