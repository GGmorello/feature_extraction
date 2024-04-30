    function parseRate(string _json) internal pure returns (string) {

        uint jsonLen = abi.encodePacked(_json).length;
        //{"ETH":}.length = 8, assuming a (maximum of) 18 digit prevision
        require(jsonLen > 8 && jsonLen <= 28, "misformatted input");

        bytes memory jsonPrefix = new bytes(7);
        copyBytes(abi.encodePacked(_json), 0, 7, jsonPrefix, 0);
        require(<FILL_ME>)

        strings.slice memory body = _json.toSlice();
        body.split(":".toSlice());
        //we are sure that ':' is included in the string, body now contains the rate+'}'
        jsonLen = body._len;
        body.until("}".toSlice());
        require(body._len == jsonLen - 1, "not json format");
        //ensure that the json is properly terminated with a '}'
        return body.toString();
    }