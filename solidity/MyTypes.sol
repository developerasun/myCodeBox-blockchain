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

    // the order of data types is important for compiler performance. do get it mixed
    uint32 one = 1111;
    uint32 two = 2222;
    uint32 three = 3333;
    uint32 four = 4444;

    // use internal if a variable only needs to be accessed in this contract
    uint16 internal secret = 99;

    // declare it as public explicitly
    address public myDummyAddress = 0xEcAB21327B6EbA1FB0631Dc9bBc5863B6B2be3E4; // default is 0x00000...00
    address public mySecondDummyAddress = 0x56012CaBddfF2bA8f3C36EBDe507eb8948c5CBfA;
}