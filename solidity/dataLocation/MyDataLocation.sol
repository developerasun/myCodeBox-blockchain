// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

/*
data location in Solidity: 

1) Storage - state variables 
2) Memory - between function call
3) Calldata - function params
4) Stack - function local variables

more on: https://github.com/developerasun/myCodeBox-blockchain/issues/26
*/

contract TransactionFactory {

    MyDataLocation[] public myDataLocations;

    function createTransaction(bytes32 _signature, uint256 _price) public {
        MyDataLocation myDataLocation = new MyDataLocation();
        myDataLocation.isStorageType(_signature, _price);
        myDataLocations.push(myDataLocation);
    }

    function getPriceOfTransaction(uint256 _index) public view returns(uint256) {
        myDataLocations[_index].getPrice(_index);
    }
}

contract MyDataLocation {

    struct Transaction {
        bytes32 senderSignature;
        uint256 price;
    }

    Transaction[] public transactions;

    function isStackType() public pure returns(bool){
        // mapping, struct, array ==> storage, memory calldata
        // bytes32 memory whatAmI = "123";  // error
        // bytes32 storage whatAmI = "123"; // error
        // bytes32 calldata whatAmI = "123"; // error
        bool isStack = true;
        return isStack;
    }

    function isMemoryType() public pure returns(bool) {
        // always choose a determistic length of bytes array if possible
        // since it is much cheaper than dynamic one. 
        bytes32[1] memory isMemory = [keccak256(abi.encodePacked("jake"))];
        if (isMemory.length == 1) return true;
        else return false;
    }

    function isStorageType(bytes32 _signature, uint256 _price) public returns(bool) {
        Transaction memory transaction = Transaction(_signature, _price);
        transactions.push(transaction);
        require(transactions.length != 0, "Array empty");

        // if first tx, fix pirce
        if (transactions.length == 1) fixTransactionPrice();
        
        return true;
    }

    function fixTransactionPrice() public {
        Transaction storage myTx = transactions[0]; 
        myTx.price = 33; 
    }

    function isCalldataType() public pure returns(bool) {
        // add it later
    }

    function getPrice(uint256 _index) public view returns(uint256) {
        transactions[_index].price;
    }
}