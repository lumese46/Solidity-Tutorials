// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// function selector 
contract func_selecto_receiver{
    event log(bytes data);
    function lumese(address _to , uint _amt) external   {
        emit log(msg.data);
    }
}