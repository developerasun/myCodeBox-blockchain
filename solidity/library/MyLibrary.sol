// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AddFive.sol"; // path should be correct 
import "./MyArray.sol";

contract MyLibrary {
    using AddFive for uint;
    using MyArray for uint[];

    uint256[] public numArray = [1,2,4];

    function useLibrary(uint _number) public pure returns(uint) {
        return _number.cal();
    }
    function getFirstElementFromArray() public pure returns(uint) {
        uint[2] memory result = MyArray.setFirstElement(4, 2);
        return result[0];
    }
    function hasElement() external view returns(bool result) {
        result = numArray.findOneElement(1);
        // result = MyArray.findOneElement(numArray, 4);
        result;
    }
}