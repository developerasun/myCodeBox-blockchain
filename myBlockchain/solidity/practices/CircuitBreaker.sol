// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract CircuitBreaker {
    bool isActive = true;
    bool transactionable = true;
    address admin;

    constructor() {
        admin = msg.sender;
    }
    
    modifier shouldBreak() {
        require(isActive != true, "Contract active now"); 
        _;
    }

    function circuitBreak() public shouldBreak {
        require(msg.sender == admin, "Only admin"); 
        transactionable = false;
    }

    // pause withdrawl when circuit breaker invokes
    function withdraw() public view{
        require(transactionable == true, "Contract inactive"); 
        // do something
    }
    
    // pause acceptance when circuit breaker invokes
    function receive() public view{
        require(transactionable == true, "Contract inactive"); 
        // do something
    }

}