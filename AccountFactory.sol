// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract AccountFactory{
    Account[] public diAcc ;
    function CreateAccount(address _owner) external payable{
        require(msg.value >= 111,"");
         diAcc.push(new Account{value: 111}(_owner));
    }
}