    function quote(address tokenIn, uint amountIn, address tokenOut, uint granularity) external view returns (uint amountOut) {
        address pair = UniswapV2Library.pairFor(factory, tokenIn, tokenOut);
        require(<FILL_ME>)
        (address token0,) = UniswapV2Library.sortTokens(tokenIn, tokenOut);

        uint priceAverageCumulative = 0;
        // SWC-Write to Arbitrary Storage Location: L669
        uint length = observations[pair].length-1;
        uint i = length.sub(granularity);


        uint nextIndex = 0;
        if (token0 == tokenIn) {
            // SWC-DoS With Block Gas Limit: L674 - L683
            for (; i < length; i++) {
                // SWC-Integer Overflow and Underflow: L675
                nextIndex = i+1;
                priceAverageCumulative += computeAmountOut(
                    observations[pair][i].price0Cumulative,
                    observations[pair][nextIndex].price0Cumulative,
                    // SWC-Integer Overflow and Underflow: L679
                    observations[pair][nextIndex].timestamp - observations[pair][i].timestamp, amountIn);
            }
        } else {
            for (; i < length; i++) {
                // SWC-DoS With Block Gas Limit: L685 - L694
                nextIndex = i+1;
                // SWC-Integer Overflow and Underflow: L685
                priceAverageCumulative += computeAmountOut(
                    observations[pair][i].price1Cumulative,
                    observations[pair][nextIndex].price1Cumulative,
                    // SWC-Integer Overflow and Underflow: L689
                    observations[pair][nextIndex].timestamp - observations[pair][i].timestamp, amountIn);
            }
        }
        return priceAverageCumulative.div(granularity);
    }