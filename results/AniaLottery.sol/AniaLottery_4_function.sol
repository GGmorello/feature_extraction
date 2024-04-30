    function addUsersToWhitelist(uint projectId, address[] calldata users, bool checkEndDate) external onlyAdmin {

        if(checkEndDate){
            require(<FILL_ME>)
        }
        // We will check if the whitelisting is open
        require(!projects[projectId].draw, "The lottery has been launched and project is completed close.");
        for (uint i; i < users.length; i++) {
            if(!_checkUserExistInProject(projectId, users[i])){
                projectsWhitelist[projectId].push(
                    Whitelist({
                        projectId: projectId,
                        userAddress: users[i],
                        signupDate: block.timestamp
                    })
                );
                projectStakeCap[projectId] += getUserTicketValue(users[i]);
                uint256 index = projectsWhitelist[projectId].length - 1;
                projectUserIndex[projectId][users[i]] = index;
                projectUserCount[projectId]++;
                emit eventAddUserToWhitelist(projectId, users[i], block.timestamp);
            }
        }
    }