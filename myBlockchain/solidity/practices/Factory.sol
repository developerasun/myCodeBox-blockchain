// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

// Factory contract creates Child contract
contract Factory {
    // create an array 
    Child[] public children;

    function createChild(address _from) public  {
        Child child = Child(_from); // calling contracts needs an address
        children.push(child);
    }
}

contract Child {
    uint256 data;

    constructor(uint256 _data) {
        data = _data;
    }
}