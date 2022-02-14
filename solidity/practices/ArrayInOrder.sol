// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
contract ArrayInOrder {
    string[] public data;

    constructor(){
        data.push('a');
        data.push('b');
        data.push('c');
        data.push('d');
    }

    function removeOne(uint256 index) public {
        require(index <= data.length-1, "index out of range"); 
        delete data[index];
    }

    function getArray() public view returns(string[] memory) {
        return data; // avoid of returning array directly(gas fee)
    }
}