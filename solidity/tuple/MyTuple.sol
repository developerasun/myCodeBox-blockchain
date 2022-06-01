// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyTuple { 

    // function returning tuples 
    function ReturnTuples() public pure returns(uint, uint, bool) {
        return (3,6, false);
    }

    // function destructuring tuples
    function DestructuringTuples() public pure returns(uint, bool) {
        // omit one uint from the tuples
        (uint myNum1, , bool myBool)= ReturnTuples();
        return (myNum1, myBool);
    }

    // function swapping values
    function Swap() public pure returns (uint, uint) {
        (uint first, uint second, ) = ReturnTuples();
        (first, second) = (second, first); // (3,6) => (6,3)
        return (first, second); // should be (6,3)
    }
}