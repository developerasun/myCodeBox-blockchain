// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract HelloWorldClone {
    // import library Strings. Strings.sol is imported in ERC721Enumerable.sol
    using Strings for uint256; 
    bytes32 public constant name = "jake";
    uint256 public wow = 3; 
    string public test = wow.toString();
}