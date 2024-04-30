    function buy(uint projectId, uint pay, address tokenForPayContractAddress) external {

        require(stableCoins[tokenForPayContractAddress], "This Token is not available for payment");

        // Payment must be greater than 0
        require(<FILL_ME>)
        require(getUserTicketValue(msg.sender) == pay, "You need to pay the exact tier value before claiming the reward");

        uint256 tokensToBuy = decimals * (pay * decimals) / projects[projectId].tokenPrice * projects[projectId].firstPayoutInPercent / 100;

        // Check requirements before any transactions
        checkBuy(projectId, tokensToBuy);

        address billingAddress = projects[projectId].billingAddress;
        address contractAddress = projects[projectId].contractAddress;
        require(billingAddress != contractAddress, "Billing Address must be different as Contract Address");

        // Create a token from a given contract address
        IERC20 token = IERC20(contractAddress);
        // I will transfer a certain number of tokens to the payer. Not all
        token.transfer(msg.sender, tokensToBuy);

        // Transfer stable Coin to Token owner
        IERC20 stableCoin = IERC20(tokenForPayContractAddress);
        stableCoin.transferFrom(msg.sender, billingAddress, pay * decimals);

        // Set the claimed attribute to true to avoid repeatedly withdrawn
        setLotteryWinnerClaimedStatus(projectId, msg.sender);
        projectRaisedAmount[projectId] += pay;
    }