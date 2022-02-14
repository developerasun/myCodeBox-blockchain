// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Usually contracts are imported from other files, not like below.
contract MyInheritance_A {
    string internal name = "Jake";
}

// contract B inherits 'name' from contract A
contract MyInheritance_B is MyInheritance_A {
    function getName() public view returns (string memory) {
        return name;
    }

    // virtual keyword makes a function overridable
    function getNameOverrides() public view virtual returns (string memory) {
        return name;
    }
}

// contract C inherits 'getName' from contract B
// contract C inherits 'getNameOverrides' from contract B
// contract C inherits 'name' from contract A
contract MyInheritance_C is MyInheritance_B{
    string public jakeName1 = getName();
    string public jakeName2 = name;

    // overrides getNameOverrides function with keyword 'override'.
    function getNameOverrides() public view virtual override returns (string memory) {
        return string(abi.encodePacked("Overriden ", name));
    }
}