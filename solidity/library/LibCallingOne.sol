// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "./IDeployedLibrary.sol";

contract LibCallingOne {

    uint256 x = 4;
    uint256 y = 2;

    // create a deployed library instance
    IDeployedLibrary lib = IDeployedLibrary(0xd9145CCE52D386f254917e481eB44e9943F39138);
    
    function callLibraryFunction() public view returns(uint256) {
        // delegatecall: execute code in library with calling contract context
        return lib.add(x, y);
    }
}