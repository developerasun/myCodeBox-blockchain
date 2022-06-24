// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// if library has only public functions(deployed library) => library will have an address, meaning
// the one deployable library can service multiple contracts

// if library has only internal functions(embedded library) => library will be inserted into
// calling contract, meaning no address for library.

library MyArray {
    error NonExisting(uint256 _element); // set custom error type

    // internal function in library doesn't need to be deployed separately
    function setFirstElement (uint256 _x, uint256 _y) internal pure returns(uint256[2] memory result)  {
       _x >= _y ? result[0]=(_x) : result[0] = _y;
       return result;
    }

    function findOneElement(uint256[] storage _arr, uint256 _num) internal view returns(bool) {
        for (uint256 i=0; i<_arr.length; i++) {
            if (_arr[i] == _num) return true;
        }
        // only revert can use error instance
        revert NonExisting({
            _element: _num
        });
    }
}