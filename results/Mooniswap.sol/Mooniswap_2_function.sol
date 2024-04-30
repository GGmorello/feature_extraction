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
        require(bytes(name).length > 0, "Mooniswap: name is empty");
        require(bytes(symbol).length > 0, "Mooniswap: symbol is empty");
        require(<FILL_ME>)
        token0 = _token0;
        token1 = _token1;
    }