    function setBuyPrice(uint newBuyPrice) 
        onlyOwner 
        public {
        require(<FILL_ME>)
        _originalBuyPrice = newBuyPrice;
        // control _maximumBuy is 10,000 USD, Gifto price is 0.1USD
        // proposed: 1 ETH = 300USD => 1 ETH = 3000 Gifto = _originalBuyPrice,
        // _maximumBuy = 10,000 / 300 = 100,000 / _originalBuyPrice ~ 33 ETH
        _maximumBuy = 100000 * 10**18 /_originalBuyPrice;
    }