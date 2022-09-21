//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "./PriceConvertor.sol";
contract FundMe{
    using PriceConvertor for uint256;
    uint256 public constant minimumUsd = 0;
    address[] public funders;
    mapping(address=>  uint256) public addressToAmountFunded;
    address public immutable owner;
    constructor(){
        owner = msg.sender;
    }

    function fund() public  payable{
        // want to be able to set a minimum fund usd
        require(msg.value.getConversionRate() >= minimumUsd , "did not send enough");
        
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;

    }
    
    function withdraw() public onlyOwner {
        
        // for loop
        // [1,2,3,4]
        for (uint256 funderIndex = 0 ; funderIndex < funders.length ; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;

        }
        // reset the array
        funders = new address[](0);
        // actually withdraw the funds
        // transfer
        //payable(msg.sender).transfer(address(this).balance);
        // send
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess,"send failed");
        // call
        (bool callSucess , ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucess, "call failed");


    }
    modifier onlyOwner {
        require(msg.sender == owner, " withdraw not allowed");
        _;
    } 
    receive() external payable{
        fund();

    }
    fallback() external payable{
        fund();
    }
    
} 