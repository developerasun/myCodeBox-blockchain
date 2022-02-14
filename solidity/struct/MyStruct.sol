// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyStruct {
    // Struct is a custom data type
    struct NFT {
        string name;
        uint256 dna;
    }

    mapping(uint256 => NFT) nftMapping;
    NFT[] public nftList; // storage data type (place it in blockchain)

    // use memory type for intermediate calculation(costing less gas)
    // and use storage type for final result
    function addNFTMemory(string memory _name, uint256 _dna) public {
        // instantiation method 1
        NFT memory newNFT = NFT(_name, _dna); // memory data type(dissappear after execution)

        // instantiation method 2
        // newNFT.name = _name;
        // newNFT.dna = _dna;
        nftList.push(newNFT); // push the instance to storage
    }

    function addNFTCalldata(NFT[] calldata _nfts) public {
        nftList = _nfts;
    }

    function getNFTname(uint256 _index) public view returns (string memory) {
        return nftList[_index].name;
    }

    // Comparison : storage vs memory
    function updateNFTStorage(uint256 _index, string memory _name) public{
        NFT storage nftToBeUpdated = nftList[_index];
        nftToBeUpdated.name = _name; // name change directly updated to blockchain for storage type
    }

    // Comparison : storage vs memory
    function updateNFTMemory(uint256 _index, string memory _name) public {
        NFT memory nftToBeUpdated = nftList[_index];
        nftToBeUpdated.name = _name; // name change coipes the instance(returns a newly copied one)
        nftList[_index] = nftToBeUpdated; // assigned the copied instance to initial storage
    }
}