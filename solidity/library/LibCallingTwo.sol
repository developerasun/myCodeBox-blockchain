// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "./IDeployedLibrary.sol";

contract LibCallingTwo {
    uint256 hundred = 100;
    uint256 fifty = 50;

    function createLibraryInstance() public pure returns(IDeployedLibrary){
        IDeployedLibrary lib = IDeployedLibrary(0xd9145CCE52D386f254917e481eB44e9943F39138);
        return lib;
    }

    function calculate() public view returns(uint256 result) {
        result = createLibraryInstance().add(hundred, fifty);
        result;
    }
}