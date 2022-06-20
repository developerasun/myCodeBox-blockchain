// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

// from openzeppelin v4.6.0, _disableInitializer should be called in consturctor to
// prevent implementation contract to be initialized
// see here: https://github.com/OpenZeppelin/openzeppelin-upgrades/issues/574

contract JakeERC20Upgradeable is Initializable, ERC20Upgradeable, OwnableUpgradeable {
    // constructor() ERC20("JakeERC20", "JK20") {}

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() external initializer {
        // should manually init all the parents
        __ERC20_init("JakeERC20Up", "JakeUp20");
        __Ownable_init();
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
