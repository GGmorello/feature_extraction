    function fraction(uint112 numerator, uint112 denominator) internal pure returns (uq112x112 memory) {
        require(<FILL_ME>)
        // SWC-Integer Overflow and Underflow: L119
        return uq112x112((uint224(numerator) << RESOLUTION) / denominator);
    }