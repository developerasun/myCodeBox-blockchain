// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

/**
Assembly syntax in Solidity enables developer to interact
with EVM directly. In this case ,the developer takes of care of
memory by oneself. This bypasses several important safety features and checks of Solidity 
so use assembly with caution.

The language used for inline assembly in Solidity is called Yul and it is documented in its own section
*/
contract MyAssembly {

    function saveDataInAssembly() external {
        uint256 one = 1;
        uint256 two = 2;
        uint three;
        // do assembly inside function.
        assembly {
            // mload(0x30) Loads the word (32byte) located at the memory address 0x30
            let a := mload(0x30)
            mstore(three, two) // temporary variable assignment
            sstore(three, one) // permanent
        }   
    }

    function getCodeSize(address _addr) external view returns(uint256) {
        uint256 size;
        address addr = _addr;
        // a regular address: 0 code size
        // smart contract address: not 0 code size
        assembly {
            size := extcodesize(addr) // returns a code size of a certain Ethereum address
        }

        return size;
    }

    function isSmartContract(address _addr) external view returns(bool) {
        uint256 _size = this.getCodeSize(_addr);
        require(_size > 0, "not a contract");
        return true;
    }
}