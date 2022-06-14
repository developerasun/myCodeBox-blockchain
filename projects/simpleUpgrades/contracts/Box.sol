// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

/// @dev This is a proxy contract that will be deployed very first.
/// @dev should be verified as proxy in Etherscan to perform read/write
contract Box {
    uint256 public val;

    function initialize(uint256 _val) external {
        val = _val;
    }
}