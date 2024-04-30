    function createCoin()
        external
        onlyWallet
    {
        require(<FILL_ME>)
        CoinCreation(new Gifto());
        flag = false;
    }