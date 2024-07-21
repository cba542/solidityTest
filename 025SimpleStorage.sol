// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract PeopleRegistry {
    struct People{
        uint age;
        string name;
    }

    mapping (string => uint) public nameToAge;
    mapping (string => uint) public nameToIndex;

    People[] public person;

    constructor(){
        // person.push(People({name:"John", age:30}));
        // person.push(People(35, "Alex"));
        // person.push(People(20, "Jenny"));

        addPerson(30, "John");
        addPerson(35, "Alex");
        addPerson(20, "Jenny");

    }
    
    function addPerson(uint _age, string memory _name) public {
        person.push(People(_age,_name));
        nameToAge[_name] = _age;
        uint index = (person.length  - 1);
        nameToIndex[_name] = index;
    }

}


