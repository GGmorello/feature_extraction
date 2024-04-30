    constructor(
        IERC20 _token0,
        IERC20 _token1,
        string memory name,
        string memory symbol,
        IMooniswapFactoryGovernance _mooniswapFactoryGovernance
    )
        public
        ERC20(name, symbol)
        MooniswapGovernance(_mooniswapFactoryGovernance)
    {
        require(<FILL_ME>)
        require(bytes(symbol).length > 0, "Mooniswap: symbol is empty");
        require(_token0 != _token1, "Mooniswap: duplicate tokens");
        token0 = _token0;
        token1 = _token1;
    }