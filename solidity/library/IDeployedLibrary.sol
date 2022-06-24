// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

interface IDeployedLibrary {
    function add(uint256 x, uint256 y) external pure returns(uint256);
}