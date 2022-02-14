// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyMapping {
    // mapping in solidity is quite important.
    // mapping takes key/value pair
    mapping(uint256 => address) public nfts;
    uint256 counter = 0;

    // returns address
    function getOwnerOfNFT(uint256 _id) public view returns(address){
        return nfts[_id]; // takes _id and maps the variable through to return a matching value. 
    }

    // match nfts keys(counter, uint256) to value(_address, address)
    function mintNFT(address _address) public {
        nfts[counter] = _address;
        counter++;
    }


}