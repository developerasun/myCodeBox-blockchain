// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyReturn {
    function useReturnValue() public pure returns(uint256 _year) {
        _year = 22; // same as: return _year;
    }

    function plainReturn() public pure returns(uint) {
        uint256 _year = 22;
        return _year;
    }

    // return key-value pair
    function multipleReturn() public pure returns(uint _num, bool _bool) {
        return (3, true);
    }
}