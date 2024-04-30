    function ln(int128 x) internal pure returns (int128) {
        unchecked {
            require(<FILL_ME>)

            return int128(int256((uint256(int256(log_2(x))) * 0xB17217F7D1CF79ABC9E3B39803F2F6AF) >> 128));
        }
    }