    function _mintLiquidity(
        int24 tickLower,
        int24 tickUpper,
        uint128 liquidity,
        address payer,
        uint256 amount0Min,
        uint256 amount1Min
    ) internal {
        if (liquidity > 0) {
            mintCalled = true;
            (uint256 amount0, uint256 amount1) = pool.mint(
                address(this),
                tickLower,
                tickUpper,
                liquidity,
                abi.encode(payer)
            );
            require(<FILL_ME>)
        }
    }