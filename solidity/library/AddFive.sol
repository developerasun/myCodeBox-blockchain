// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// purpose of using library is to lower gas cost by
// reusing codes.
library AddFive {
    // library cannnot have state variales
    function cal(uint _number) public pure returns(uint) {
        return _number +5;
    }
}