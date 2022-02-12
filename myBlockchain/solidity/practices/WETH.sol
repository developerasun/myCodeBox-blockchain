// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "../../../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WETH is ERC20{

    constructor() ERC20("MyWETH", "WETH") {}

    function mint() external payable {
        _mint(msg.sender, msg.value);
    }

    function burn(uint256 _amount) external {
        _burn(msg.sender, _amount); // burn _amount of token when called by msg.sender
    }
}