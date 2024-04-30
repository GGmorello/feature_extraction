    function div(uq112x112 memory self, uint112 x) internal pure returns (uq112x112 memory) {
        require(<FILL_ME>)
        // SWC-Integer Overflow and Underflow: L102
        return uq112x112(self._x / uint224(x));
    }