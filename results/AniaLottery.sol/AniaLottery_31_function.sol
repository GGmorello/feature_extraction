    function signUpToWhitelist(uint projectId) external {
        // We will check if the whitelisting is open
        require(_checkOpenProject(projectId), "Project is close.");
        // We will check if the user exists in the list
        require(<FILL_ME>)
        projectsWhitelist[projectId].push(
            Whitelist({
                projectId: projectId,
                userAddress: msg.sender,
                signupDate: block.timestamp
            })
        );
        projectStakeCap[projectId] += getUserTicketValue(msg.sender);
        uint256 index = projectsWhitelist[projectId].length - 1;
        projectUserIndex[projectId][msg.sender] = index;
        projectUserCount[projectId]++;
        emit eventAddUserToWhitelist(projectId, msg.sender, block.timestamp);
    }