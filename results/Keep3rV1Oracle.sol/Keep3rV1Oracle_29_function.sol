    function current(address tokenIn, uint amountIn, address tokenOut) external view returns (uint amountOut) {
        address pair = UniswapV2Library.pairFor(factory, tokenIn, tokenOut);
        require(<FILL_ME>)
        (address token0,) = UniswapV2Library.sortTokens(tokenIn, tokenOut);

        Observation memory _observation = lastObservation(pair);
        (uint price0Cumulative, uint price1Cumulative,) = UniswapV2OracleLibrary.currentCumulativePrices(pair);
        if (block.timestamp == _observation.timestamp) {
            _observation = observations[pair][observations[pair].length-2];
        }

        // SWC-Integer Overflow and Underflow: L651
        uint timeElapsed = block.timestamp - _observation.timestamp;
        timeElapsed = timeElapsed == 0 ? 1 : timeElapsed;
        if (token0 == tokenIn) {
            return computeAmountOut(_observation.price0Cumulative, price0Cumulative, timeElapsed, amountIn);
        } else {
            return computeAmountOut(_observation.price1Cumulative, price1Cumulative, timeElapsed, amountIn);
        }
    }