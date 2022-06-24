// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/**

Transparent: proxy + admin, more expensive than UUPS
UUPS(Universal Upgradeable Proxy Standard):  proxy itself not upgradeable


UUPS proxies do not contain an upgrade mechanism on the proxy, 
and it has to be included in the implementation. 
We can add this mechanism by inheriting UUPSUpgradeable.
*/
contract ERC20UpgradeableWithUUPS is Initializable, ERC20Upgradeable, OwnableUpgradeable, UUPSUpgradeable {
    // state variables with no initial values
    uint256 number;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __ERC20_init("JakeUUPS", "JKUUPS");
        __Ownable_init(); // default is a msg.sender, changeable
        __UUPSUpgradeable_init();
        number = 100;
    }

    // set who can upgrade contract with access control
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    function getNumber() public view returns (uint256) {
        return number + 5;
    }
}
