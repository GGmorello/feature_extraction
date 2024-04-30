    constructor(
        address _pool,
        address _owner,
        string memory name,
        string memory symbol
    ) ERC20Permit(name) ERC20(name, symbol) {
        require(_pool != address(0));
        require(_owner != address(0));
        pool = IUniswapV3Pool(_pool);
        token0 = IERC20(pool.token0());
        token1 = IERC20(pool.token1());
        require(address(token0) != address(0));
        require(<FILL_ME>)
        fee = pool.fee();
        tickSpacing = pool.tickSpacing();

        owner = _owner;

        maxTotalSupply = 0; /// no cap
        deposit0Max = uint256(-1);
        deposit1Max = uint256(-1);
    }