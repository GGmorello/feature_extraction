    function div(int128 x, int128 y) internal pure returns (int128) {
        unchecked {
            require(<FILL_ME>)
            int256 result = (int256(x) << 64) / y;
            require(result >= MIN_64x64 && result <= MAX_64x64);
            return int128(result);
        }
    }