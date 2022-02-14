// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyIfElse {
    uint256 public revealState = 0;
    bool public isNowRevealed = false;
    string public status = "not yet revealed";

    function addToRevealState() public {
        revealState++;
    }

    function isRevealed() public {
        if(revealState >= 10) {
            isNowRevealed = true;
            status = "now revealed!";
        }
        else if (revealState >= 7) {
            status = "almost there";
        }
        else { 
            status = "gotta wait for more";
        }
    }  
}