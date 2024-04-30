    constructor(
        IERC20 _inboundCurrency,
        IERC20 _matoken,
        IERC20 _quick,
        IRouter _router,
        IPair _pair,
        IStake _stakingPool,
        uint256 _segmentCount,
        uint256 _segmentLength,
        uint256 _segmentPayment,
        uint256 _earlyWithdrawalFee
    ) public {
        // Initializes default variables
        firstSegmentStart = block.timestamp; //gets current time
        lastSegment = _segmentCount;
        segmentLength = _segmentLength;
        segmentPayment = _segmentPayment;
        earlyWithdrawalFee = _earlyWithdrawalFee;
        mtoken = _inboundCurrency;
        matoken = _matoken;
        quick = _quick;
        router = _router;
        pair = _pair;
        stakingPool = _stakingPool;

        uint256 MAX_ALLOWANCE = 2**256 - 1;
        require(
            _inboundCurrency.approve(address(router), MAX_ALLOWANCE),
            "Fail to approve allowance to router"
        );
        require(
            _matoken.approve(address(router), MAX_ALLOWANCE),
            "Fail to approve allowance to router"
        );

        require(<FILL_ME>)

    }

    function pause() external onlyOwner whenNotPaused {