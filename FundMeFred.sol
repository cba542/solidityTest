// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    AggregatorV3Interface internal dataFeed;

    address public owner;

    uint minimumUSB = 10;
    constructor(){
        owner = msg.sender;

        /**
        * Network: Sepolia
        * Aggregator: BTC/USD
        * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        * Network: Sepolia
        * Aggregator: ETH/USD
        * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        */
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

    function Fund() public payable{
        require(convertEthToUsd(msg.value) > minimumUSB, "must greater that 1e");
    }

    function withdraw() view public {
        require(msg.sender == owner, "not contract developer");
    }

    /**
     * Returns the latest answer.
     */
    function getChainlinkDataFeedLatestAnswer() public view returns (uint) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int answer,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return uint(answer);
    }

    function convertEthToUsd(uint ethAmount) public view returns (uint) {
        uint ethprice = getChainlinkDataFeedLatestAnswer();
        // Chainlink returns price with 8 decimal places, we need to adjust it to 18 decimal places
        uint ethInUsd = (ethprice * ethAmount)/1e26;
        return ethInUsd;
    }


}