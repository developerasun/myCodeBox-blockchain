// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
contract Ticket {
    // set ticket cost
    uint256 public ticketCost = 0.05 ether;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }

    // ticket holder and amount of tickets
    mapping(address => uint256) public ticketHolder; 

    function buyTicket(address _user, uint256 _amount) public payable{
        require(msg.value >= ticketCost * _amount, "Each ticket costs 0.05 ether.");
        addTicket(_user, _amount);
    }

    function useTicket(address _user, uint256 _amount) public {
        subTicket(_user, _amount);
    }
    
    function addTicket(address _user, uint256 _amount) internal {
        ticketHolder[_user] = ticketHolder[_user] + _amount;
    }

    function subTicket(address _user, uint256 _amount) internal{
        require(ticketHolder[_user] >= _amount, "You do not have enough tickets");
        ticketHolder[_user] = ticketHolder[_user] - _amount;
    }

    function withdraw() public payable { 
        require(msg.sender == owner, "You are not contract owner"); 
        (bool isSent, ) = payable(owner).call{ value : address(this).balance }(""); 
        require(isSent);
    }

    function getBalance() public view onlyOwner returns(uint256) { 
        return address(this).balance;
    }
}