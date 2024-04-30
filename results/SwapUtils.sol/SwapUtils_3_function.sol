    function getY(
        Swap storage self, uint8 tokenIndexFrom, uint8 tokenIndexTo, uint256 x,
        uint256[] memory xp
    ) internal view returns (uint256) {
        uint256 numTokens = self.pooledTokens.length;
        require(tokenIndexFrom != tokenIndexTo, "Can't compare token to itself");
        require(<FILL_ME>)


        uint256 _A = getA(self);
        uint256 D = getD(xp, _A);
        uint256 c = D;
        uint256 s = 0;
        uint256 nA = numTokens.mul(_A);
        uint256 cDivider = 1;

        uint256 _x = 0;
        for (uint i = 0; i < numTokens; i++) {
            if (i == tokenIndexFrom) {
                _x = x;
            } else if (i != tokenIndexTo) {
                _x = xp[i];
            }
            else {
                continue;
            }
            s = s.add(_x);
            c = c.mul(D);
            cDivider = cDivider.mul(_x).mul(numTokens);
        }
        c = c.mul(D).div(nA.mul(numTokens).mul(cDivider));
        uint256 b = s.add(D.div(nA));
        uint256 yPrev = 0;
        uint256 y = D;

        // iterative approximation
        for (uint i = 0; i < 256; i++) {
            yPrev = y;
            y = y.mul(y).add(c).div(y.mul(2).add(b).sub(D));
            if (y.within1(yPrev)) {
                break;
            }
        }
        return y;
    }

    /**