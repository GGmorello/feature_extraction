    function _doTransfers(IERC20 src, IERC20 dst, uint256 amount, uint256 minReturn, address payable receiver, Balances memory balances, Fees memory fees)
        private returns(uint256 confirmed, uint256 result, Balances memory virtualBalances)
    {
        uint256 _decayPeriod = decayPeriod();
        virtualBalances.src = virtualBalancesForAddition[src].current(_decayPeriod, balances.src);
        virtualBalances.src = Math.max(virtualBalances.src, balances.src);
        virtualBalances.dst = virtualBalancesForRemoval[dst].current(_decayPeriod, balances.dst);
        virtualBalances.dst = Math.min(virtualBalances.dst, balances.dst);
        src.uniTransferFrom(msg.sender, address(this), amount);
        confirmed = src.uniBalanceOf(address(this)).sub(balances.src);
        result = _getReturn(src, dst, confirmed, virtualBalances.src, virtualBalances.dst, fees.fee, fees.slippageFee);
        require(<FILL_ME>)
        dst.uniTransfer(receiver, result);

        // Update virtual balances to the same direction only at imbalanced state
        if (virtualBalances.src != balances.src) {
            virtualBalancesForAddition[src].set(virtualBalances.src.add(confirmed));
        }
        if (virtualBalances.dst != balances.dst) {
            virtualBalancesForRemoval[dst].set(virtualBalances.dst.sub(result));
        }
        // Update virtual balances to the opposite direction
        virtualBalancesForRemoval[src].update(_decayPeriod, balances.src);
        virtualBalancesForAddition[dst].update(_decayPeriod, balances.dst);
    }