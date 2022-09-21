// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract EventChild is Event{
    function send(string calldata _text , uint _value) external override{
        emit molaetsa(_text , _value + 8);
    }
}