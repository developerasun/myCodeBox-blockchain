// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyEvent { 
    // event is a way to read dat and find out
    // what happens in a transaction from event log

    event CreatedNFT(address indexed user, uint256 id, uint256 dna);

    function createNFT(uint256 _id, uint256 _dna) public {
        emit CreatedNFT(msg.sender, _id, _dna); // save these arguments in blockchain trasaction
    }
}