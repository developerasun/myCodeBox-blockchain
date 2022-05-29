// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AddFive.sol"; // path should be correct 
contract MyLibrary {
    using AddFive for uint;

    function useLibrary(uint _number) public pure returns(uint) {
        return _number.cal();
    }
}