    function joinGame() external whenNotPaused {
        require(<FILL_ME>)
        require(
            players[msg.sender].addr != msg.sender,
            "Cannot join the game more than once"
        );
        Player memory newPlayer = Player({
            addr: msg.sender,
            mostRecentSegmentPaid: 0,
            amountPaid: 0,
            withdrawn: false
        });
        players[msg.sender] = newPlayer;
        iterablePlayers.push(msg.sender);
        emit JoinedGame(msg.sender, segmentPayment);

        // payment for first segment
        _transferDaiToContract();
    }