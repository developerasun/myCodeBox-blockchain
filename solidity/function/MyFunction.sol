// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract MyFunction {
    uint256 myState = 256; 
    uint8 myAge = 27;
    string name = "Jake";

    // Functions can be declared pure in which case they promise 
    // not to read from or modify the state.
    function myPureFunc(uint256 x, uint256 y) public pure returns(uint256){
        return x + y;
    }

    function myViewFunc() public view returns(string memory) {
        return name;
    }

    function secretlyReturnGreeting() private pure returns(string memory) {
        return "Hello Anna";
    }

    function myUpdateFunc() public returns(string memory){ 
        string memory secretString = secretlyReturnGreeting(); // private function can get called inside contract.
        name = secretString;
        return name;
    }

    // External function can only get executed outside contract
    function myExternalFunc() external{
        myAge = 50;
    }

    // function can return multiple values
    function myMultipleReturnFunc() public pure returns(uint8, string memory) {
        return (8, "hello"); // wrap return values with parenthesis
    }
}