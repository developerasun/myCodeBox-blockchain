// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";

// openzeppelin team provides a tutorial : https://forum.openzeppelin.com/t/uups-proxies-tutorial-solidity-javascript/7786

contract MyUpgradable is Initializable, ERC20Upgradeable {
    // modifier initializer
        // naming convention 
    function initialize() initializer public { 
        __ERC20_init("MyUpgradableERC20", "UPERC20");
        _mint(msg.sender, 1000 * 10* decimals());
    }

    constructor() initializer {}
}
