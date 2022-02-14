// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyTypes {
    // limit the use of string type since it is not primitive type of solidity.
    // string in solidity is similar to byte array, costing a lot of gas.
    string public name = "Jake Sung";

    bool myBool; // default is false

    // picking the smallest unit is important in smart contract since it affects gas cost.
    // variables by default are private. 
    uint256 my256Uint = 24564654; // 2 ** 256 -1
    uint32 my32Uint = 56444; // 2 ** 32 -1 
    uint16 my16Uint = 2222; // 2 ** 16 -1
    uint8 my8Uint = 255; // 0 ~ 255 : 2 ** 8 -1 

    // the order of data types is important for compiler performance. do not get it mixed
    uint32 one = 1111;
    uint32 two = 2222;
    uint32 three = 3333;
    uint32 four = 4444;

    // use internal if a variable only needs to be accessed in this contract
    uint16 internal secret = 99;

    uint256 myNewVar = uint256(my32Uint); // specify exact type 

    // declare it as public explicitly
    address public myDummyAddress = address(0xD8C824685151edd16617dD2860884bA411276dC6); // default is 0x00000...00
    address myContractAddress = address(this); // smart contract instance from remix 
    
    uint256 test = myContractAddress.balance;
}