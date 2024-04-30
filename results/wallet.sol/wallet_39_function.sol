    function _bytesToAddress(bytes _bts, uint _from) private pure returns (address) {
        require(<FILL_ME>)

        uint160 m = 0;
        uint160 b = 0;

        for (uint8 i = 0; i < 20; i++) {
            m *= 256;
            b = uint160 (_bts[_from + i]);
            m += (b);
        }

        return address(m);
    }