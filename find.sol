// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// ways you create and use a library
library find{
    function min(uint x , uint y) internal pure  returns(uint){
        return x >= y ? x : y;
    }

    function arrFind(uint[] storage _arr ,  uint _num) internal view returns(uint){
       for (uint i = 0 ;  i < _arr.length ; i++){
           if (_arr[i] == _num ){
               return i;
           }
       }
       
        revert("could not find");
    }
}