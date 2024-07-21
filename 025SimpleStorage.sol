// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract PeopleRegistry {
    struct People{
        uint age;
        string name;
    }

    People[] public person;

    constructor(){
        person.push(People({name:"John", age:30}));
        person.push(People(35, "Alex"));
        person.push(People(20, "Jenny"));
    }
    

}


