// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10; 

// use ERC721.sol directly rather ERC721Enumerable.sol to lower gas
import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";

contract Playground is ERC721, Ownable{ 
    // import library : syntax is "using library for type"
    using Strings for uint256;
    using Counters for Counters.Counter;
    
    address owner;
    uint256 test = 0;

    // Create Counter instance
    Counters.Counter public myCounter;
    uint256 zero = myCounter.current();
    
    function increaseCounter() public { 
        // increate Counter struct's _value property
        myCounter.increment();
    }

    // inherit ERC721 token 
    constructor()ERC721("NAME", "SYMBOL") {
        owner = msg.sender;
    }

    // check ERC721 functions : balanceOf
    function checkBalanceOf() public { 
        balanceOf(owner);
    }
    
    // check ERC721 functions : _safeMint
    function checkSafeMint(uint256 _tokenId) public { 
        _safeMint(owner, _tokenId);
    }
}