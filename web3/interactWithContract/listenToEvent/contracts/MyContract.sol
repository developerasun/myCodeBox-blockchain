// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract MyContract {
    // indexed event value is searchable in front end
    event MyEvent (
        uint256 indexed id,
        uint256 indexed data,
        string indexed value  
    );

    uint256 nextId;

    function emitEvent(string calldata value) external {
        emit MyEvent(nextId, block.timestamp, value);
        nextId++;
    }
}