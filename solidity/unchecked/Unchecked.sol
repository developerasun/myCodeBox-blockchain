// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract Unchecked {
    function f(uint a, uint b) pure public returns (uint) {
        // This subtraction will wrap on underflow.
        // f(2,3) => will execute
        unchecked { return a - b; }
    }
    function g(uint a, uint b) pure public returns (uint) {
        // g(2,3) => will revert
        // This subtraction will revert on underflow.
        return a - b;
    }
}