    function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA > 0, 'UniswapV2Library: INSUFFICIENT_AMOUNT');
        require(<FILL_ME>)
        // SWC-Integer Overflow and Underflow: L383
        amountB = amountA.mul(reserveB) / reserveA;
    }