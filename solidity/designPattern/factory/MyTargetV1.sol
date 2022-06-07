// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract MyTargetV1 {
    uint256 public myNum = 999;

    function getFive() public pure returns(uint256) {
        return 5;
    }

    function updateMyNum(uint256 _myNum) public {
        myNum = _myNum;
    }

    function calculate() public view returns(uint256) {
        return myNum + getFive();
    }
    
    function getMyNum() public view returns(uint256) {
        return myNum;
    }
}