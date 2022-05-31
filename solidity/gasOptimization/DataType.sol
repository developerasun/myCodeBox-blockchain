// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
contract DataType {
    uint8 resulta = 0;
    uint resultb = 0;
    

    // uint256 takes less gas than uint8
    function UseUint() external returns (uint) {
        uint selectedRange = 50;
        for (uint i=0; i < selectedRange; i++) {
            resultb += 1;
        }
        return resultb;
    }
    
    // uint8: more gas
    function UseUInt8() external returns (uint8){
        uint8 selectedRange = 50;
        for (uint8 i=0; i < selectedRange; i++) {
            resulta += 1;
        }
        return resulta;
    }
}