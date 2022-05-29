// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract MyString is ERC721Enumerable {

    // ERC721Enumerable needs to have ERC721 first
    constructor()ERC721( "test name", "test symbol" ){}

    // number to string
    using Strings for uint256;
    uint256 public number = 3; 

    // below only works for uint256. not uint, 128 .. etc
    string public converted = number.toString(); // statically typed
    
    function getConverted() public view returns (string memory) {
        return converted;
    }

    // checking aa+b == a+ab in Solidity: true, same
    // abi.encodePacked(arg): returns bytes
    // keccak256: returns bytes32
    function isTheSameString() public pure returns (bool) {
        return (keccak256(abi.encodePacked("aa", "b")) == keccak256(abi.encodePacked("a", "ab")));
    }

    function compareEcodedPacked() public pure returns(bool) {
        // below not working
        return (abi.encodePacked("ab","b") == abi.encodePacked("a","bb"));
    }

    function concatenateString(string memory s1, string memory s2) public pure returns (string memory) {
        // convert abi.encodePacked's return value to string
        return string(abi.encodePacked(s1, s2));
    }
}