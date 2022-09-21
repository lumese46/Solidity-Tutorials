//SPDX-License-Identifier: MIT
pragma solidity 0.8.8; 

contract SimpleStorage {
    //bool hasFavoriteNumber = true;
    uint256 public favoriteNumber = 123;
    //string favoriteNumberInText = "lumesestallion";
    //int256 favoriteInt = -123;
    //address myAddress = 0xcB17CB8eb24Fa645E1b192De05047f00085c21B5;
    //bytes32 favoriteBytes = "cat";
    //People public person = People({favoriteNumber : 2, name : "lumese"});
    mapping (string => uint256) public nameToFavoriteNumber;
    struct People {
        uint256 favoriteNumber;
        string name; 
    }
    People[] public people;
    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber; 
        //favoriteNumber = favoriteNumber + 1;

    }
    function addPerson( string memory _name , uint256 _favoriteNumber ) public {
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;

    }

    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

}