// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;


// anyone can send eth to the contract 
// but only the owner can withdraw eth and after 
//owner withdraw eth the contract is destroyed
contract PiggyBank{
    address public owner;
    event deposit(address _address , uint value);
    event Withdraw(address _address , uint value);
    constructor() payable{
        owner = payable(msg.sender);
    }

    receive() payable external{
        emit deposit(msg.sender, msg.value);

    }
    function withdraw() external payable onlyOwner{
        emit Withdraw(msg.sender, address(this).balance);
        selfdestruct(payable (msg.sender));
    }

    modifier onlyOwner(){
        require(msg.sender == owner , "You're not the owner");
        _;
    }
    
}
