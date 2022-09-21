// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract proxy{
   struct tacks{
       string description;
       bool taskStatus;
   }

   tacks[] public  myToDoList;


    // function that is going to add task

    function addTask(string calldata desc , bool tS) external{
        myToDoList.push(tacks(desc,tS));
    }

    function upDateTask(uint _index ,string calldata _newDesc , bool _newTs) external {
        tacks storage _udTacks = myToDoList[_index];
        _udTacks.description = _newDesc;
        _udTacks.taskStatus = _newTs;
    }


    // function to get a ToDo task

    function getTask(uint _index) external view returns (string  memory , bool ){
        return  (myToDoList[_index].description , myToDoList[_index].taskStatus);
    }

}