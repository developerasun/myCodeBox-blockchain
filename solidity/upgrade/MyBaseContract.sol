// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**
initializer modifier == bool private initialized + require(!initialized, "initialize only once")
parent intialize function must be called in child contract since it won't be invoked
automatically unlike constructor
*/

// Initializer modifier for Proxy contract
contract BaseContract is Initializable {
    uint256 public num;
    // bool private initialized; // default is false

    function initialize() public initializer {
        // require(!initialized, "initialize only once");
        // initialized = true;
        num = 5; // can be updated in deploying script
    }
}

contract MyContract is BaseContract {
    uint256 public myNum;

    function initialize(uint256 _num) public initializer {
        BaseContract.initialize(); // Do not forget this call!
        myNum = _num;
    }
}