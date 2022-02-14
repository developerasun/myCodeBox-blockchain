// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/finance/PaymentSplitter.sol";

/**
    * @dev Creates an instance of `PaymentSplitter` where each account in `payees` is assigned the number of shares at
    * the matching position in the `shares` array.
    *
    * All addresses in `payees` must be non-zero. Both arrays must have the same non-zero length, and there must be no
    * duplicates in `payees`.
    */
contract MyPayment is PaymentSplitter {
    constructor(address[] memory _payees, uint256[] memory _shares) PaymentSplitter(_payees, _shares) payable {}
}

/* payees : 
["0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db",
"0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB"]
*/

// shares : [ 30, 50, 20 ]