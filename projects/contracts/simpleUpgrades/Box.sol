// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/// @dev This is a proxy contract that will be deployed very first.
/// @dev should be verified as proxy in Etherscan to perform read/write
contract Box {
    uint256 public val;
    uint256 public val2;

    function initialize(uint256 _val) external {
        val = _val;
    }
}
