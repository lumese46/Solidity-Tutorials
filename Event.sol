// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract Event {
    event molaetsa(string text , uint value);

    function send(string calldata _text, uint _value ) external virtual {
        emit molaetsa(_text , _value);
    }
}