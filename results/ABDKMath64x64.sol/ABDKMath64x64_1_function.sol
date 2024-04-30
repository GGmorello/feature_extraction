    function fromUInt(uint256 x) internal pure returns (int128) {
        unchecked {
            require(<FILL_ME>)
            return int128(int256(x << 64));
        }
    }