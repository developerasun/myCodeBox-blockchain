// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// custom error type
error NotEnoughFunds(uint256 required, uint256 left);

contract MyRevertAndError {

    // assumed some token ledger
    mapping(address=>uint) tokenHolderBalance;

    function trasnferSomeToken(address to, uint256 amount) public {
        // transfer failed
        if (amount > tokenHolderBalance[msg.sender]) { 
            // note that only revert can create error instance
            revert NotEnoughFunds({
                required: amount, 
                left: tokenHolderBalance[msg.sender]
            });
        }

        // transfer success
        tokenHolderBalance[to] += amount;
        tokenHolderBalance[msg.sender] -= amount;
    }
}