    function redeemFromExternalPool(uint256 _slippage)
        public
        whenGameIsCompleted
    {
        require(!redeemed, "Redeem operation already happened for the game");
        redeemed = true;
        if (matoken.balanceOf(address(this)) > 0) {
            // claiming rewards and getting back the staked lp tokens
            // no return param here
            stakingPool.exit();
            // swap the claimed quick rewards with mtoken
            address[] memory inversePairTokens = new address[](2);
            inversePairTokens[0] = address(quick);
            inversePairTokens[1] = address(mtoken);

            // getting the minAmount with slippage in consideration
            uint256 minAmount = getMinOutputAmount(
                quick.balanceOf(address(this)),
                _slippage
            );
            uint256[] memory amounts = router.swapExactTokensForTokens(
                quick.balanceOf(address(this)),
                minAmount,
                inversePairTokens,
                address(this),
                now.add(1200)
            );
            // since in path param we just have the 2 tokens hence checking the only element in the amounts array.
            require(amounts[0] > 0, "Output token amount is 0");
            // remove 100% liquidity to get back the deposited mtoken and matoken
            (uint256 amountA, uint256 amountB) = router.removeLiquidity(
                address(mtoken),
                address(matoken),
                pair.balanceOf(address(this)),
                0,
                0,
                address(this),
                now.add(1200)
            );
            require(amountA > 0, "mtoken amount is 0");
            require(amountB > 0, "matoken amount is 0");
            // swapping the matoken for mtoken
            inversePairTokens[0] = address(matoken);

            // getting the minAmount with slippage in consideration
            minAmount = getMinOutputAmount(
                matoken.balanceOf(address(this)),
                _slippage
            );
            amounts = router.swapExactTokensForTokens(
                matoken.balanceOf(address(this)),
                minAmount,
                inversePairTokens,
                address(this),
                now.add(1200)
            );
            require(amounts[0] > 0, "Output token amount is 0");
        }
        uint256 totalBalance = IERC20(mtoken).balanceOf(address(this));
        // recording principal amount separately since adai balance will have interest has well
        if (totalBalance > totalGamePrincipal) {
            totalGameInterest = totalBalance.sub(totalGamePrincipal);
        } else {
            totalGameInterest = 0;
        }

        emit FundsRedeemedFromExternalPool(
            totalBalance,
            totalGamePrincipal,
            totalGameInterest
        );
        emit WinnersAnnouncement(winners);

        if (winners.length == 0) {
            require(<FILL_ME>)

        }
    }

    // to be called by individual players to get the amount back once it is redeemed following the solidity withdraw pattern