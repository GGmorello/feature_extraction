    function lotteryDraw(uint projectId, address[] calldata users) external onlyAdmin {
        require(_checkProjectExistById(projectId), "Project with this ID does not exist.");
        require(!_checkOpenProject(projectId), "Project is open and should be closed.");
        // We will check if the lottery is open
        require(<FILL_ME>)

        for (uint i; i < users.length; i++) {
            address user = users[i];
            if(_checkUserExistInProject(projectId, user) && !_checkUserIsProjectWinner(projectId, user)){
                uint reward = getUserTicketValue(user);
                if (reward > 0) {
                    lotteryWinners[projectId].push(
                        LotteryWinner({
                            projectId: projectId,
                            userAddress: user,
                            reward: reward,
                            claimed: false
                        })
                    );
                    uint256 index = lotteryWinners[projectId].length - 1;
                    projectWinnerIndex[projectId][user] = index;
                    lotteryWinnerCount[projectId]++;
                    emit eventAddUserToLotteryWinners(projectId, user, reward, 0);
                }
            }
        }

        // Set the project lottery draw status to true to avoid multiple lottery rounds
        projects[projectId].draw = true;
    }