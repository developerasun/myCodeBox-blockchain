// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyArray {
    uint256[] private arr1 ;
    uint256[] public arr2 = [1,2,3];
    uint256[3] public arr3 = [4,5,6];

    uint256 public arrayLength = arr2.length;

    function addOneElementToArray(uint256 newElement) public {
        arr2.push(newElement);
    }

    function deleteOneElementFromArray(uint256 deleteThis) public {
        delete arr2[deleteThis];
    }
}