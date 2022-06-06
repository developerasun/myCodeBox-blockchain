// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

///@author @developerasun
/*
1. You should be running a blockchain to check balance transfer. Try hardhat or ganache.
2. The amount of Ether will be moved from msg.sender to receiver. Check blockchain logs in above network.
3. Among send, transfer, call methods, call with reentrancy guard is recommended for Ether transfer 
because of gas cost and security.

e.g.
- contract: 0x2279B7A0a67DB372996a5FaB50D91eAA73d2eBe6
- from: hardhat user1: msg.sender(account): 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
- to: hardhat user2: 0x70997970c51812dc3a010c7d01b50e0d17dc79c8
*/

contract MyPayable {

    function getBalance(address _user) public view returns(uint256) {
        uint256 amount = address(_user).balance ;
        return amount;
    }

    // method to send Ether 1: address.transfer, 2300 gas, throws error
    function transferEth(address payable receiver) public payable {
        receiver.transfer(msg.value); // msg.value : number of wei sent with the message
    }
    
    // method to send Ether 2: address.send => 2300 gas, returns bool
    function sendEthe(address payable receiver) public payable {
        bool isSent = receiver.send(msg.value);
        require(isSent, "Sending Ether failed");
    }
    
    // method to send Ether 3: address.call => forward all gas, returns bool
    // Which method should you use? 
    // call in combination with re-entrancy guard is the recommended method to use after December 2019.
    // Guard against re-entrancy by making all state changes 
    // before calling other contracts using re-entrancy guard modifier
    function callEth(address payable receiver) public payable {
        // call method returns bool and bytes memory
        // The empty argument triggers the fallback function of the receiving address.
        (bool isSent, ) = receiver.call{gas: 10000, value : msg.value}("");
        require(isSent);
    }

     // Function to receive Ether. msg.data must be empty
    receive() external payable {} // receive takes no argument, cannot have returns, should be external

    // Fallback function is called when msg.data is not empty
    // using fallback is not recommended because of the interface confusion failure
    fallback() external payable {}
}