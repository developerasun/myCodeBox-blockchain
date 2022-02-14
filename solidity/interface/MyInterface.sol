// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// define an interface 
interface ICounter {
    // function signature in interface => not implement. only siganture.
    function count() external view returns (uint256);
    function addToCount() external;
}

// MyInterface contract implement ICounter interface.
contract MyInterface is ICounter{ 
    uint256 counter = 0;

    // implement the functions from interface
    function count() external view override returns (uint256) {
        return counter;
    }

    function addToCount() external override {
        counter++;
    }
}