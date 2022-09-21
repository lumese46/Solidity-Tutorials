//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; 
import "./SimpleStorage.sol";
contract StorageFactory{
    SimpleStorage[] public simplestoragArray;
    function createSimpleStorageContract() public {
        simplestoragArray.push(new SimpleStorage() );
        // = new SimpleStorage();
    }
    function sfStore(uint256 _simpleStorageIndex , uint256 _simpleStorageNumber) public {
        // need the address and the abi
        SimpleStorage simpleStorage = simplestoragArray[_simpleStorageIndex]; 
        simpleStorage.store(_simpleStorageNumber);

    }
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256){
        SimpleStorage simpleStorage = simplestoragArray[_simpleStorageIndex]; 
        return simpleStorage.retrieve();

    }
}