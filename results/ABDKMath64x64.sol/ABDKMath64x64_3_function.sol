    function from128x128(int256 x) internal pure returns (int128) {
        unchecked {
            int256 result = x >> 64;
            require(<FILL_ME>)
            return int128(result);
        }
    }