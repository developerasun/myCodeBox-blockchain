// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract Public {
    // public function => copies arguments from memory. can be called both externally and internally 
    // external function => read arguments from calldata. can't be called internally
    // gas cost: public > external

    uint16 year = 2022;

    // public
    function getThisYear() public view returns(uint16) {
        return year;
    }

    // external. can't be called in this contract without 'this' keyword
    function getThisYearPlusOne() external view returns(uint16) {
        return year +1;
    }
}