// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract MyIterableMapping {
    mapping(address => uint256) public balances;
    mapping(address => bool) public inserted;
    address[] public key;

    function set(address _address, uint256 _val) external {
        balances[_address] = _val;

        if(!inserted[_address]) key.push(_address);
    }

    // get mapping size by converting it to array
    function getSize() external view returns(uint256) {
        return key.length;
    }

    function first() external view returns(uint256) {
        return balances[key[0]];
    }

    function last() external view returns(uint256) {
        return balances[key[key.length-1]];
    }

    function get(uint256 _index) external view returns(uint256) {
        return balances[key[_index]];
    }
}