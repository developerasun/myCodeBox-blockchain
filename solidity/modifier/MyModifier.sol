// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InheritModifier {
    // modifier is overridable
    modifier changeMyNum() virtual {
        _;
    }
}

contract MyModifier is InheritModifier {
    uint256 public myNum = 0;
    bool paused = false;
    address public owner;

    constructor() {
        owner = address(msg.sender);
    }
    // modifier is used to change function behavior. 
    modifier checkPaused() {
        require(paused == false, "Contract is paused");
        _; // move to next code blocks and execute it. Similiar to Nodejs next().
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can execute.");
        _;
    }

    // It also can take parameter if needed 
    modifier withParameters(uint8 number) {
        require(number > 10, "number should be larger than 10");
        _;
    }

    // Overriding modifier
    modifier changeMyNum() override {
        myNum = 4;
        _;
    }

    function setPause() public changeMyNum { 
        paused = !paused;
    }

    // attach modifier to addToNum
    function addToNum() public checkPaused onlyOwner{
        myNum++;
    }

    // attach modifier to subToNum
    function subToNum() public checkPaused onlyOwner withParameters(11){
        myNum--;
    }
}