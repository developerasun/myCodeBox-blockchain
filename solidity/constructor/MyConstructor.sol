// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract MyConstructor { 
    string public name; 

    // constructor gets called when contract deployed
    // A constructor is optional and only one constructor is allowed 
    // constructor does not need a semicolon.
    constructor(string memory _name) {
        name = _name; // will be initialized during deployment
    }
}

contract MySecondContract is MyConstructor{
    // constructor inheritance
    constructor(string memory _name) MyConstructor(_name){}
}