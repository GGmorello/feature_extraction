    function earlyWithdraw(uint256 _slippage)
        external
        whenNotPaused
        whenGameIsNotCompleted
    {
        Player storage player = players[msg.sender];
        // Makes sure player didn't withdraw; otherwise, player could withdraw multiple times.
        require(!player.withdrawn, "Player has already withdrawn");
        player.withdrawn = true;
        // In an early withdraw, users get their principal minus the earlyWithdrawalFee % defined in the constructor.
        // So if earlyWithdrawalFee is 10% and deposit amount is 10 musdc, player will get 9 musdc back, keeping 1 dai in the pool.
        uint256 withdrawAmount = player.amountPaid.sub(
            player.amountPaid.mul(earlyWithdrawalFee).div(100)
        );
        // Decreases the totalGamePrincipal on earlyWithdraw
        totalGamePrincipal = totalGamePrincipal.sub(withdrawAmount);
        uint256 currentSegment = getCurrentSegment();
        if (currentSegment > 0) {
            currentSegment = currentSegment.sub(1);
        }
        if (segmentDeposit[currentSegment] > 0) {
            if (segmentDeposit[currentSegment] >= withdrawAmount) {
                segmentDeposit[currentSegment] = segmentDeposit[currentSegment]
                    .sub(withdrawAmount);
            } else {
                segmentDeposit[currentSegment] = 0;
            }
        }

        uint256 contractBalance = IERC20(mtoken).balanceOf(address(this));

        emit EarlyWithdrawal(msg.sender, withdrawAmount);

        // Only withdraw funds from underlying pool if contract doesn't have enough balance to fulfill the early withdraw.
        // there is no redeem function in v2 it is replaced by withdraw in v2
        if (contractBalance < withdrawAmount) {
            address[] memory path = new address[](2);
            path[0] = address(mtoken);
            path[1] = address(matoken);

            uint256[] memory outputAmt = router.getAmountsOut(
                withdrawAmount.sub(contractBalance),
                path
            );
            uint256 poolTokensToBurn = getLPTokenAmount(
                withdrawAmount.sub(contractBalance),
                outputAmt[0]
            );
            // remove liquidity to get back the deposited mtoken and matoken
            (, uint256 amountB) = router.removeLiquidity(
                address(mtoken),
                address(matoken),
                poolTokensToBurn,
                0,
                0,
                address(this),
                now.add(1200)
            );
            require(amountB > 0, "matoken amount is 0");
            // after some liquidity is burnt if still the balance is low then only do a reverse swap
            if (
                IERC20(mtoken).balanceOf(address(this)) <
                withdrawAmount.sub(contractBalance)
            ) {
                // swap the received matoken after removing liquidity
                address[] memory inversePairTokens = new address[](2);
                inversePairTokens[0] = address(matoken);
                inversePairTokens[1] = address(mtoken);

                // getting the minAmount with slippage in consideration
                uint256 minAmount = getMinOutputAmount(amountB, _slippage);
                uint256[] memory amounts = router.swapExactTokensForTokens(
                    amountB,
                    minAmount,
                    inversePairTokens,
                    address(this),
                    now.add(1200)
                );
                // since in path param we just have the 2 tokens hence checking the only element in the amounts array.
                require(amounts[0] > 0, "Output token amount is 0");
            }
        }
        require(<FILL_ME>)

    }

    /**