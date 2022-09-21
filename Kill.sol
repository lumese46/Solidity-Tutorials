// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
// this is how you delete a contruct
//selfdestruct
// - delete contract 
// - force send ether to my address
contract Kill{
    constructor() payable{}
    function kill() external {
        selfdestruct(payable(msg.sender));
    }
    function testCall() external pure returns(uint){
        return 123;
    }
}