    function inv(int128 x) internal pure returns (int128) {
        unchecked {
            require(<FILL_ME>)
            int256 result = int256(0x100000000000000000000000000000000) / x;
            require(result >= MIN_64x64 && result <= MAX_64x64);
            return int128(result);
        }
    }