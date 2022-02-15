// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract MyContract {
    string public functionCalled; 

    function sendEther() external payable {
        functionCalled = 'ether sent';
    }    
}