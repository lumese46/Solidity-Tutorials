// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract etherWallet{
    address payable public owner ;
    mapping (address => uint ) public payers;
    constructor(){
        owner = payable(msg.sender);
    }

    receive() external payable{

    }

    function withDrawEth(uint value ) external {
        require(msg.sender == owner,"You are not the owner");
        payable(msg.sender).transfer(value);
    }
    function GetBalance() external view returns(uint){
        return address(this).balance;
    }
    
}