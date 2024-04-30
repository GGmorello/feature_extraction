    function withdraw(uint256 _slippage) external {
        Player storage player = players[msg.sender];
        require(<FILL_ME>)
        player.withdrawn = true;

        uint256 payout = player.amountPaid;
        if (player.mostRecentSegmentPaid == lastSegment.sub(1)) {
            // Player is a winner and gets a bonus!
            // No need to worry about if winners.length = 0
            // If we're in this block then the user is a winner
            // only add interest if there are winners
            if (winners.length > 0) {
                payout = payout.add(totalGameInterest.div(winners.length));
            }        }
        emit Withdrawal(msg.sender, payout);

        // First player to withdraw redeems everyone's funds
        if (!redeemed) {
            redeemFromExternalPool(_slippage);
        }

        require(
            IERC20(mtoken).transfer(msg.sender, payout),
            "Fail to transfer ERC20 tokens on withdraw"
        );
    }