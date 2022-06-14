// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

contract MyDynamicPrice {
    uint256 price = 1 ether;
    uint256 totalTokenSupply = 100;
    address owner;
    bool raised = false;
    
    constructor(){ owner = msg.sender; }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    modifier shouldRaise() {
        if (totalTokenSupply < 80) raised = true;
        _;
    }
    // 소비자가 동적 가격 확인을 gas fee 지출 없이 할 수 있도록 코드 전개

    // setter
    function updatePrice() private shouldRaise {
        if (raised) price = 1.5 ether;
    }

    // mint and check if total supply
    function mintToken() public {
        totalTokenSupply = totalTokenSupply - 10;
        updatePrice(); // weakness: when limit hits, mint price goes up 
    }

    // getter
    function getCurrentPrice() external view returns(uint256) {
        // assumed formula: current price * 2 + 10 === changed price
        // price will change based on totalTokenSupply
        uint256 dynamicPrice = price * 2 + 10; 
        return dynamicPrice;
    }
}