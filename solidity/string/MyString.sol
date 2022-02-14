// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "../../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract MyString is ERC721Enumerable {

    // ERC721Enumerable needs to have ERC721 first
    constructor()ERC721( "test name", "test symbol" ){}

    // number to string
    using Strings for uint256;
    uint256 public number = 3; 
    string public converted = number.toString(); // statically typed
    
    function getConverted() public view returns (string memory) {
        return converted;
    }

}