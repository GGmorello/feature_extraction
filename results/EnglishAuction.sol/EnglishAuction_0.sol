// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EnglishAuction {

    function start() external {
        <REQUIRE>
        require(msg.sender == seller, "not seller");
    }

}
