// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @author @developerasun

// base contract can have both implemented/unimplemented functions
abstract contract MyAbstract {
    // abstract function(should have virtual keyword)
    function getFive() internal virtual returns(uint8);

    // implented function
    function getTen() internal pure returns(uint8) {
        return 10;
    }
}

contract GetAbstract is MyAbstract {
    // overriding abstract function
    function getFive() internal virtual override returns(uint8) {

        // use implemeted function
        uint8 ten = MyAbstract.getTen();
        return ten - 5;
    }
}