// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// source codes from: https://github.com/willitscale/learning-solidity/blob/master/tutorial-08/Debugging.sol
/* Notes

key element in Solidity debugging: Solidity locals

Three places to look at Remix debugging tool
1. things in stack
2. things in memory
3. things in storage


- instructions: opcodes executed in assembly
- take a look at Solidity locals to check how values changed
*/
contract MyDebug {
    uint[] private vars;
    
    // 3 failing functions
    function assignment() public pure {
        uint myVal1 = 1;
        uint myVal2 = 2;
        assert(myVal1 == myVal2);
    }
    
    function memoryAlloc() public pure {
        string memory myString = "test";
        assert(bytes(myString).length == 10);
    }
    
    function storageAlloc() public {
        vars.push(2);
        vars.push(3);
        assert(vars.length == 4);
    }
}