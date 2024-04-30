    function joinGame() external whenNotPaused {
        require(getCurrentSegment() == 0, "Game has already started");
        require(<FILL_ME>)

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

    /**