    function toUInt(int128 x) internal pure returns (uint64) {
        unchecked {
            require(<FILL_ME>)
            return uint64(uint128(x >> 64));
        }
    }