// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BobToken is ERC20 {
    constructor() ERC20("BOB", "B") {
        _mint(msg.sender, 100 * uint256(10**decimals()));
    }
}
