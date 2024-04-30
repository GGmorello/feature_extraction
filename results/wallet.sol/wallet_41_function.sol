    function _sliceUint(bytes _bts, uint _from) private pure returns (uint) {
        require(<FILL_ME>)

        uint x;
        assembly {
            x := mload(add(_bts, add(0x20, _from)))
        }

        return x;
    }