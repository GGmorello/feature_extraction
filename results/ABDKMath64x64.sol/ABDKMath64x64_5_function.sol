    function sub(int128 x, int128 y) internal pure returns (int128) {
        unchecked {
            int256 result = int256(x) - y;
            require(<FILL_ME>)
            return int128(result);
        }
    }