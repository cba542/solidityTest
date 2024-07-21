// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FundMe{
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function withdraw() view public {
        require(msg.sender == owner, "not contract developer");
    }
}