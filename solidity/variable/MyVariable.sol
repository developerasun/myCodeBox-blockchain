// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyVariables { 
    uint256 public myNumber = 20; // state variable, living forever with smart contract
    bool private paused = true; // state variable
    uint256 internal time = block.timestamp; // block is a global variable that is in blockchain

    function myFunc() public view {
        // uint256 localNumber = 20; // local variable(will disappear after function call)
        // bool localPaused = true;
        // address theSenderAddress = msg.sender; // current function call. can vary
    }
}

// Inheritance in Solidity
contract YourVariables is MyVariables { 
    uint256 public yourVar = 200; 
    uint256 theTime = time;
    bool public paused = false; // this paused variable is different from above one.
}