// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyEvent { 
    // event is a way to read dat and find out
    // what happens in a transaction from event log

    // indexed params only available up to 3
    event CreatedNFT(address indexed user, uint256 id, uint256 dna);

    function createNFT(uint256 _id, uint256 _dna) public {
        emit CreatedNFT(msg.sender, _id, _dna); // save these arguments in blockchain trasaction
    }
}

contract DoEvent {
    uint256 public one = 1;
    event Log(string indexed message, uint value);
    
    // emitting event is a transactional function, meaning cost gas
    // event can't be checked in blockchain. only outside the blockchain(e.g front end)
    function EmitEvent() public {
        emit Log("this year is", 2022);
    }

    // view, pure do not cost gas mostly.
    // only cost gas when called inside contract
    function getOne() public view returns(uint256) {
        return one;
    }
}