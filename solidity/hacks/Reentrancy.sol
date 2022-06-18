// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract Reentrancy {
    // incorrect
    function withdrawFunds() external {
        uint256 amount = balace[msg.sender];
        require(msg.sender.call.value(amount));
        // race condition might occur
        balance[msg.sender] = 0;
    }

    // correct
    function withdrawFunds() external {
        uint256 amount = balace[msg.sender];
        // race condition solved. look simple but significant.
        balance[msg.sender] = 0;
        require(msg.sender.call.value(amount));
    }
}
