// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

// deployed address in Remix: 0xd9145CCE52D386f254917e481eB44e9943F39138
/**

how to use a deployed library(the one with itw own address)

1. create a library with all public functions
2. deploy the library
3. create an interface that with library function signature
4. create a library instance in calling contract
5. set the same state variables in the calling contract for delegatecall
6. use the deployed library

*/
library DeployedLibrary {
    function add(uint256 x, uint256 y) public pure returns(uint256 result) {
        result = x + y;
        result;
    }
}