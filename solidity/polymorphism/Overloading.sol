// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @author @developerasun 
contract Overloading {
    uint256 private fixedNumber = 444; 

    function isGreaterThanFive(uint8 number) internal pure returns(bool) {
        require(number > 5, "Less than five");
        return true;
    }

    // function overloading: same name with different parameter.
    // note that return type not counted for Solidity overloading
    function isGreaterThanFive() public view returns(bool) {
        if (fixedNumber > 5) { return true; }
        return false;
    } 
}