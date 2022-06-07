// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

/**

- delegatecall only takes codes. not context like msg

1. a contract to be version-controlled deployed(version 1)
2. Factory contract(contract creator)
3. deliver version 1 address and create version 2(cheaper, )
4. repeat 

version 2 contract is cheaper => delegatecall
version 1 contract's constructor not called => delegatecall
version 1 contract not affected => delegatecall 

- this way, user can interact with version 1 contract with original address
without any confusion.

 */

// Proxy contract only has a delegatecall inside.
contract MyProxy {
    address masterCopy;
    constructor(address _masterCopy) {
        masterCopy = _masterCopy;
    }

    function forward() external returns (bytes memory) {
        (bool success, bytes memory data) = masterCopy.delegatecall(msg.data);
        require(success);
        return data;
    }
}

// high level language ====(compile)====> byte code =====> EVM