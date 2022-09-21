//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConvertor {
    function getPrice() internal view returns(uint256){
        // Adress of the contract 0x9326BFA02ADD2366b30bacB125260Af641031331
        //  ABI of the contract
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        (, int256 price , , ,  ) = priceFeed.latestRoundData();
        // eth price in usd
        return uint256(price * 1e10);


    }
    function getConversionRate(uint256 ethAmount) internal  view returns(uint256) {
        uint256 ethPrice = getPrice(); // price is in wei
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;// price to normal
        return ethAmountInUsd;
    }
}
