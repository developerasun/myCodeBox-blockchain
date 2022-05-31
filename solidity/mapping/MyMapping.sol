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

contract MapOperation {
    // Mappings are mostly used to associate 
    // the unique Ethereum address with the associated value type.
    mapping (address => bool)[] isKorean;

    // array length should be allocated first
    // otherwise write functionality won't work
    function allocate(uint256 space) public {
        for (uint256 i =0; i < space; i++) {
            isKorean.push();
        }
    }
    
    // write 
    function writeMap(uint256 index, address key, bool value) public {
        isKorean[index][key] = value;
    }

    // read: check if assignable
    function getArrayLength() public view returns(uint256 length) {
        length = isKorean.length;
    }

    function readMap(uint256 index, address key) public view returns(bool _isKorean) {
        _isKorean = isKorean[index][key];
    }

    // delete
    function deleteMap() public {
        delete isKorean;
    }

    function deleteOne(uint256 index, address key) public {
        delete isKorean[index][key];
    }
}

contract Map {
    mapping (uint => uint)[] array;

    function allocate(uint newMaps) public {
        for (uint i = 0; i < newMaps; i++)
            array.push();
    }

    function writeMap(uint map, uint key, uint value) public {
        array[map][key] = value;
    }

    function readMap(uint map, uint key) public view returns (uint) {
        return array[map][key];
    }

    function eraseMaps() public {
        delete array;
    }
}