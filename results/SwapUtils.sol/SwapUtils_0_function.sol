    function getYD(uint256 _A, uint8 tokenIndex, uint256[] memory xp, uint256 D)
        internal pure returns (uint256) {
        uint256 numTokens = xp.length;
        require(<FILL_ME>)

        uint256 c = D;
        uint256 s = 0;
        uint256 nA = _A.mul(numTokens);
        uint256 cDivider = 1;

        for (uint i = 0; i < numTokens; i++) {
            if (i != tokenIndex) {
                s = s.add(xp[i]);
                c = c.mul(D);
                cDivider = cDivider.mul(xp[i]).mul(numTokens);
            } else {
                continue;
            }
        }
        c = c.mul(D).div(nA.mul(numTokens).mul(cDivider));

        uint256 b = s.add(D.div(nA));
        uint256 yPrev = 0;
        uint256 y = D;
        for (uint i = 0; i<256; i++) {
            yPrev = y;
            y = y.mul(y).add(c).div(y.mul(2).add(b).sub(D));
            if(y.within1(yPrev)) {
                break;
            }
        }
        return y;
    }