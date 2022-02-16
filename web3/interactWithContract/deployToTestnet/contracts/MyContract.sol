// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract MyContract {
    uint256 data; 

    function getData() external view returns(uint256) {
        return data;
    }

    function setData(uint256 _data) external {
        data = _data; 
    }
}