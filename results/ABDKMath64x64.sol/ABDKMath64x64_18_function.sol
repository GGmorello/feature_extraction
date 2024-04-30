    function divu(uint256 x, uint256 y) internal pure returns (int128) {
        unchecked {
            require(<FILL_ME>)
            uint128 result = divuu(x, y);
            require(result <= uint128(MAX_64x64));
            return int128(result);
        }
    }