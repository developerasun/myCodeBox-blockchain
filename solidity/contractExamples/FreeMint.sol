// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/// @author Jake Sung
/// @dev Mint free of charge up to 3(total supply). Paid mint costs 0.05 ether after.
contract FreeMint {
    uint256 public freeMintSupply=3; 
    uint256 public paidMintCost = 0.05 ether;

    mapping(address => uint256) holderAndAmount; 
    mapping(uint256 => address) tokenAndholder;

    // if freeMintSupply > 0, require no msg.value
    function freeMint(address to, uint256 tokenId) public {
        require(freeMintSupply > 0, "All minted");
        mint(to, tokenId);
        freeMintSupply--;
    }

    function mint(address to, uint256 tokenId) internal { 
        holderAndAmount[to] += 1;
        tokenAndholder[tokenId] = to;
    }

    function paidMint(address to, uint256 tokenId) public payable {
        require( msg.value >= paidMintCost, "paid minting cost 0.05 ether");
        holderAndAmount[to] += 1;
        tokenAndholder[tokenId] = to;
    }

    function amountOf(address holder) public view returns(uint256) {
        return holderAndAmount[holder];
    }

    function ownerOf(uint256 tokenId) public view returns(address) {
        return tokenAndholder[tokenId];
    }

}