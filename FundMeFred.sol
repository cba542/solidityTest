// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    AggregatorV3Interface internal dataFeed;

    address public owner;

    uint minimumUSB = 10;

    address[] public funders;
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
        // require(convertEthToUsd(msg.value) > minimumUSB, "must greater that 1e");

        funders.push(msg.sender);
    }

    function withdraw() public {
        require(msg.sender == owner, "not contract developer");

        //Transfer and send gas fee limited to 2300
        // payable(msg.sender).transfer(address(this).balance);
        // bool sendPASS = payable(msg.sender).send(address(this).balance);
        // require(sendPASS, "transaction failed");

        (bool callPass,) = payable(msg.sender).call{value:address(this).balance}("");
        require(callPass, "transaction failed");
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