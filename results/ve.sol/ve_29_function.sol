    function tokenURI(uint _tokenId) external view returns (string memory) {
        require(<FILL_ME>)
        LockedBalance memory _locked = locked[_tokenId];
        return
        _tokenURI(
            _tokenId,
            _balanceOfNFT(_tokenId, block.timestamp),
            _locked.end,
            uint(int256(_locked.amount))
        );
    }