// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract Account{
    address public bank;
    address public owner;



    constructor(address _owner) payable {
        bank = msg.sender;
        owner = _owner;
    }
}