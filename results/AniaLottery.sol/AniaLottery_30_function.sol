    function signUpToWhitelist(uint projectId) external {
        // We will check if the whitelisting is open
        require(<FILL_ME>)
        // We will check if the user exists in the list
        require(!_checkUserExistInProject(projectId, msg.sender), "User is already in whitelist.");
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