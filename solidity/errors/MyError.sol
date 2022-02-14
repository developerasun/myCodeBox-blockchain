// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyError {
    // three ways to validate data in Solidity before execution 
    // 1) require, 2) revert : takes two parameters(evaluate, error) usually inside function.  
    // 3) assert : mostly not used. special case.
    function myPureFunc(uint8 _x, uint8 _y) public pure returns(uint8){
        
        // the code block stops and evaluate if this is true. If true, continue.
        require(_x > _y, "x should be bigger than y"); 
        return _x + _y ;
    }

    function useRevert(uint8 _x, uint8 _y) public pure returns(uint8){
        if (_x == 10) {
            revert("x can't be 10");
        }
        if (_y == 20) {
            revert("y can't be 20");
        }
        return _x + _y;
    }
}