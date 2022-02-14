// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract HelloWorld {
    string public message;
    address public owner;
    
    constructor(string memory _message) {
        message = _message; 
        owner = msg.sender; // set contract invoker to owner
    }

    function getMessage() public view returns (string memory) {
        return message;
    }

    function setMessage(string memory _message) public payable {
        require(msg.value >= 1 ether, "message fee costs 1 ether");
        message = _message; 
    } 
}