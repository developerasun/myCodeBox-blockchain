// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract DealWithString {

    // manipulating string in solidity could consume a lot of gas
    string public name = "Jake Sung"; 
    string public city = "in Seoul";

    function getNameLength() external view returns(uint256) {
        // string should be converted to bytes to get length
        return bytes(name).length;
    }

    function concatNameToCity() external view returns(string memory) {
        return string(abi.encodePacked(name, city));
    }

    function concatString() external pure returns(bytes memory) {
        return string.concat("hey", "bye");
    }

    function getReversedName() external view returns(string memory) {
        bytes memory str = bytes(name);
        string memory temp = new string(str.length);
        bytes memory _reverse = bytes(temp);

        for (uint256 i=0; i<str.length; i++) {
            _reverse[str.length - 1 - i] = str[i]; 
        }
        return string(_reverse);
    }

    function compareNameAndCity() external view returns(bool) {
        // convert string to btyes to compare
        bytes32 hashedName = keccak256(abi.encodePacked(name));
        bytes32 hashedCity = keccak256(abi.encodePacked(city));

        return hashedName == hashedCity;
    }

}