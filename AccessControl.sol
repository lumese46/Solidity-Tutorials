// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.10;

contract AccessControl{

    // this is events that will be written on the blockchain when roles are given
    // use indexed so that we can navigate events easily
    event GrantRole(bytes32 indexed  _role,address indexed _address );
    event RevokeRole(bytes32 indexed  _role,address indexed _address );
    // use a nested mapping and this mapping create a automatic get function since its public
    mapping (bytes32  => mapping (address=> bool)) public roles;

    // hashing roles into bytes to shrink the length of the string and to save
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));


    // this function will be used by the constructor and its helper 
    // function that adds a role to the mapping roles
    function _grantRole(bytes32  _role , address _account) internal  {
        if (_role == ADMIN || _role == USER){
            roles[_role][_account] = true;
            emit GrantRole(_role,_account);
        }
        else{
            revert("ROLE DOES NOT EXIST");
        }
        
    }

    //when constructor is called the address that deploys the contract becomes admin 
    constructor() {
        _grantRole(ADMIN, msg.sender);
    } 
    // this is a grant roles contract and only the admin can grant roles using function modifier
    function grantRole(bytes32  _role , address _account) external OnlyRole(ADMIN)  { 
        _grantRole(_role , _account);
    }


    // this is used to take away a role from an address 
    function revokeRole(bytes32  _role , address _account) external OnlyRole(ADMIN)  { 
        roles[_role][_account] = false;
        emit RevokeRole(_role,_account);
    }


    // this is a function modifier and it only allows this role to use certain functions
    modifier OnlyRole(bytes32 _role){
        require(roles[_role][msg.sender] , "Not Authorized");
        _;
    }



}