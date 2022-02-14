// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyPayable {
    address payable public myAddress; 

    constructor() payable {
        myAddress = payable(msg.sender);
    }

    function deposit() public payable {

    }

    function getBalance() public view returns(uint256) {
        uint256 amount = address(this).balance ;
        return amount;
    }

    // method to send Ether 1
    function transferEth(address payable _user) public payable {
        _user.transfer(msg.value); // msg.value : number of wei sent with the message
    }
    
    // method to send Ether 2
    function sendEthe(address payable _user) public payable {
        bool isSent = _user.send(msg.value);
        require(isSent, "Sending Ether failed");
    }
    
    // method to send Ether 3
    function callEth(address payable _user) public payable {
        (bool isSent, ) = _user.call{ value : msg.value }("");
        require(isSent);
    }

     // Function to receive Ether. msg.data must be empty
    receive() external payable {} // receive takes no argument, cannot have returns, should be external

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}
}