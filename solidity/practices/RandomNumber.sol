// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// create one more contract containing 
// one random number generation variable
contract Oracle { 
    address admin;
    uint256 public rand;

    constructor( ){
        admin = msg.sender;
    }

    function invokeRandomness(uint256 _rand) external {
        require(msg.sender == admin, "only admin"); 
        rand = _rand;
    }
}

contract RandomNumber{ 
    // set contract instance
    Oracle oracle; 
    uint256 nonce;

    constructor(address oracleAddress) {
        // initialize the instance with address
        oracle = Oracle(oracleAddress);
    }

    function unsafe_Randness(uint256 mod) external view returns(uint256) {
        // this way of random number is not recommended since miner can 
        // manipulate the variables related to blocks. 
        return uint(
                keccak256(
                    abi.encodePacked(
                    block.timestamp, 
                    block.difficulty, 
                    msg.sender))) % mod; 
    }
    
    function safe_Randomness() external returns(uint256) {

        uint256 rand = uint256(keccak256(abi.encodePacked(
            // add nonce(private var), oracle.rand(another contract var)
            // to secure random number
            nonce, oracle.rand, block.difficulty, msg.sender
        )));
        nonce++;

        return rand;
    }
}