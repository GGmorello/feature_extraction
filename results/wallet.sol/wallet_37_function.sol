    function convertToStablecoin(address _token, uint _amount) public view returns (uint) {
        //avoid the unnecessary calculations if the token to be loaded is the stablecoin itself
        if (_token == _stablecoin()) {
            return _amount;
        }
        //0x0 represents ether
        if (_token != address(0)) {
            //convert to eth first, same as convertToEther()
            // Store the token in memory to save map entry lookup gas.
            (,uint256 magnitude, uint256 rate, bool available, , , ) = _getTokenInfo(_token);
            // require that token both exists in the whitelist and its rate is not zero.
            require(available, "token is not available");
            require(rate != 0, "token rate is 0");
            // Safely convert the token amount to ether based on the exchange rate.
            _amount = _amount.mul(rate).div(magnitude);
        }
        //_amount now is in ether
        // Get the stablecoin's magnitude and its current rate.
        ( ,uint256 stablecoinMagnitude, uint256 stablecoinRate, bool stablecoinAvailable, , , ) = _getStablecoinInfo();
            // Check if the stablecoin rate is set.
        require(<FILL_ME>)
        require(stablecoinRate != 0, "stablecoin rate is 0");
        // Safely convert the token amount to stablecoin based on its exchange rate and the stablecoin exchange rate.
        // SWC-Integer Overflow and Underflow: L707
        return _amount.mul(stablecoinMagnitude).div(stablecoinRate);
    }