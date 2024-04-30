    function getProjectUser(uint projectId, address userAddress) public view returns (Whitelist memory) {
        uint256 index = projectUserIndex[projectId][userAddress];
        require(<FILL_ME>)
        return projectsWhitelist[projectId][index];
    }