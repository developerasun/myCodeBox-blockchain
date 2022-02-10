// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/security/Pausable.sol";

contract MyPausable is Pausable {

    // by default paused in Pausable.sol is false
    function foo() external view whenNotPaused returns(string memory) { 
        return "contract not paused"; // executable
    }

    function bar() external view whenPaused returns(string memory) {
        return "contract paused"; // not executable
    }
}