// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Jake {
    string name = "Jake Sung";

    function getName() public view returns(string memory) {
        return name;
    }
}