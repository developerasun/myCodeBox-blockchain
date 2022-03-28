// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Internal { 
    string public fullName = "Jake Sung";
    function fetchName() internal view returns(string memory) {
        return fullName;
    }
    function privatelyFetchName() private view returns(string memory) {
        return fullName;
    }
}

contract External is Internal {
    string public name = "Jake";

    // external function can't be called internally
    function getName() external view returns(string memory) {
        return name;
    }

    function executeGetName() public view returns(string memory) { 
        // but this.external works
        string memory checkName = this.getName();
        return checkName;
    }

    function executeFetchName() public view returns(string memory) {
        // can call internal function when inherited
        string memory myFullName = fetchName();
        return myFullName;
    }

    function executePrivateFetchName() public {
        // can't call private function in another contract
        // string memory check = privatelyFetchName();
    }
    
}