// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// this is how we use the keccak256 hash function

contract test_keccak256{
    
    // encodePacked returns a bytes 32 and it can cause collisons if the same dynamic data types are used in a row
    function hash_func(address _myAddress , uint _secretInt , string memory _secretString) external pure returns(bytes32){
        return keccak256(abi.encodePacked(_myAddress,_secretInt,_secretString));
    }

    // encode returns a bytes and it does not compress data like encodePacked
    function hash_func_encode(string memory _test_1 , string memory _test_2) external pure returns (bytes32 ){
        return keccak256(abi.encode(_test_2,_test_1));
    }
}
