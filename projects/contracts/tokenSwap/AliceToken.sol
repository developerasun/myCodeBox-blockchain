// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AliceToken is ERC20 {
    constructor() ERC20("ALICE", "A"){
        // the amount of tokens wanting to mint = the amount * (10 ** decimals)
        // 10 * decimals: token base unit
        // amount * token base unit = the number of tokens
        _mint(msg.sender, 100 * uint256(10 ** decimals()));
    }
}
