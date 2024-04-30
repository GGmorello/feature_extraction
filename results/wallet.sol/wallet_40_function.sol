    function _bytesToUint32(bytes _bts, uint _from) private pure returns (uint32) {
        require(<FILL_ME>)

        uint32 m = 0;
        uint32 b = 0;

        for (uint8 i = 0; i < 4; i++) {
            m *= 256;
            b = uint32 (_bts[_from + i]);
            m += (b);
        }

        return m;
    }