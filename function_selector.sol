// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract function_selector{

    function select(string calldata _find) external pure returns (bytes4){
        return bytes4(keccak256(bytes(_find)));
    }
}
//end of function selector