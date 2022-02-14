// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Jake {
    bytes32 name = "Jake Sung";

    function getName() public view returns(bytes32) {
        return name;
    }
}