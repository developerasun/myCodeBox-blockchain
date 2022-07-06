// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

// deployed counter contract
contract Counter { 
    uint256 public number = 0;

    function count() external view returns(uint256) {
        return number;
    }
    function increment() external {
        number = number + 1;
    }
}