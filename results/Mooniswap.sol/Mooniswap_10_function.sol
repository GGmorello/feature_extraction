    function swapFor(IERC20 src, IERC20 dst, uint256 amount, uint256 minReturn, address referral, address payable receiver) public payable nonReentrant returns(uint256 result) {
        require(<FILL_ME>)

        Balances memory balances = Balances({
            src: src.uniBalanceOf(address(this)).sub(src.isETH() ? msg.value : 0),
            dst: dst.uniBalanceOf(address(this))
        });
        uint256 confirmed;
        Balances memory virtualBalances;
        Fees memory fees = Fees({
            fee: fee(),
            slippageFee: slippageFee()
        });
        (confirmed, result, virtualBalances) = _doTransfers(src, dst, amount, minReturn, receiver, balances, fees);
        _mintRewards(confirmed, result, referral, balances, fees);
        emit Swapped(msg.sender, receiver, address(src), address(dst), confirmed, result, virtualBalances.src, virtualBalances.dst, referral);

        // Overflow of uint128 is desired
        volumes[src].confirmed += uint128(confirmed);
        volumes[src].result += uint128(result);
    }