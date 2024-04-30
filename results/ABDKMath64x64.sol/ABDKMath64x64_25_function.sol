    function gavg(int128 x, int128 y) internal pure returns (int128) {
        unchecked {
            int256 m = int256(x) * int256(y);
            require(m >= 0);
            require(<FILL_ME>)
            return int128(sqrtu(uint256(m)));
        }
    }