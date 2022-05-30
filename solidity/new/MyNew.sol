// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

///@author @developerasun

/*
A contract can create other contracts using the new keyword. 
The full code of the contract being created has to be known 
when the creating contract is compiled so recursive 
creation-dependencies are not possible.
*/

contract Data {
    uint16 public secret = 777;
    function getSecret() external view returns(uint16) {
        return secret;
    }
}

contract Receipt { 
    uint public amount;
    constructor(uint _amount) payable {
        amount = _amount;
    }
}

contract MyNew {
    // constructor can be omitted. optional.

    function useDataContract() public returns(uint16){
        Data data = new Data(); // create a contract instance.
        uint16 fromData = data.getSecret();
        return fromData;
    }

    function sendEthWhileCreation() public returns(uint) {
        Receipt receipt = new Receipt(100);
        return receipt.amount();
    }
}