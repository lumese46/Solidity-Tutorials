// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract test_find_library{

    using find for uint[];
    uint[] public arr;
    // this is the first way of testing this contract
    function test_min(uint x , uint y) external pure returns(uint){
        return find.min(x,y);
    }

    // this is the second way of testing this contract
    function test_arrFind(uint _num) external view returns (uint){
        return arr.arrFind( _num);
    }

}