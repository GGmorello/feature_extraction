    function convertToEther(address _token, uint _amount) public view returns (uint) {
        // Store the token in memory to save map entry lookup gas.
        (,uint256 magnitude, uint256 rate, bool available, , , ) = _getTokenInfo(_token);
        // If the token exists require that its rate is not zero.
        if (available) {
            require(<FILL_ME>)
            // Safely convert the token amount to ether based on the exchange rate.
            // SWC-Integer Overflow and Underflow: L562
            return _amount.mul(rate).div(magnitude);
        }
        return 0;
    }