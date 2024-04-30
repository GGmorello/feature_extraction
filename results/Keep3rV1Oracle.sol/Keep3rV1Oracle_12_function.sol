    function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(<FILL_ME>)
        require(reserveA > 0 && reserveB > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        // SWC-Integer Overflow and Underflow: L383
        amountB = amountA.mul(reserveB) / reserveA;
    }