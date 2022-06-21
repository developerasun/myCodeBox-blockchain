// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// try to limit your read/write towards state variable
// instead, create local variables in function and update it to the state variables last.
contract ForLoop {
    uint myNum; // default is 0
    
    // expected gas cost in Remix: 21444
    function ResetMyNum() public {
        myNum = 0;
    }

    // expected gas cost in Remix: 49419
    function UseManyGas() public returns(uint){
        for (uint i=0; i<10; i++) {
            myNum += i; // change state variable(which is in storage) a lot
        }
        return myNum; // should be 45,
    }

    // expected gas cost in Remix: 47462 (spend 4% less gas)
    function UseLittleGas() public returns(uint) {
        uint wrapper;
        for (uint j=0; j<10; j++) {
            wrapper += j; // change local variable
        }
        myNum = wrapper; // update state variable
        return myNum; // should be 45
    }
}