// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract helper_for_kill{

    function getBalance() external view returns(uint){
        
        return address(this).balance;
    }

    function callKill(address _kill) external  {
        Kill n = Kill(_kill);
        n.kill();
    }
}