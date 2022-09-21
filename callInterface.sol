// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

interface Icounter{
    function count() external view  returns(uint);
    function inc() external;
}

contract callInterface{
    function examples(address _counter) external{
        Icounter(_counter).inc();
        Icounter(_counter).count();
    }
}