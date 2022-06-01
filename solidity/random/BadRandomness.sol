// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
see here for more: https://fravoll.github.io/solidity-patterns/randomness.html
Implemented like this there are two problems, making this solution impractical:

a miner could withhold a found block, if the random number derived from the block hash would be to his disadvantage. 
By withholding the block, the miner would of course lose out on the block reward. 
This problem is therefore only relevant in cases the monetary value relying on the random number 
is at least comparatively high as the current block reward.
the more concerning problem is that since block.number is a variable available on the blockchain, 
it can be used as an input parameter by any user. In case of a gambling contract, 
a user could use uint(blockhash(block.number - 1) as the input for his bet and always win the game.
*/
contract BadRandomness {

    // Randomness provided by this is predicatable. Use with care!
    // blockhash(uint blockNumber): hash of the given block - only works for 256 most recent, excluding current, blocks
    // block.number: (uint): current block number
    function randomNumber() internal view returns (uint) {
        return uint(blockhash(block.number - 1));
    }
}