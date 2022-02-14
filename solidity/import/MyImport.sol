// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

contract NFT { 
    uint256 dna;
    string name;

    constructor(string memory _name, uint256 _dna) {
        dna = _dna;
        name = _name;
    }
}

// MyImport inherits ERC721
contract MyImport is ERC721 { 
    NFT[] public nfts;
    
    bytes32 myByteName = "Jake";

    // you can check ERC721 details here : https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_){}

    function addNFT(string memory _name, uint256 _dna) public {
        NFT nft = new NFT(_name, _dna);
        nfts.push(nft);
    }

    function myHashedName(string memory _name) public pure returns(bytes32) {
        // keccak is a built-in hash function in Solidity
        // abi.encodePacked : Performs packed encoding of the given argument
        return keccak256(abi.encodePacked(_name));
    }
}