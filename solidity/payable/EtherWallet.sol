// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

/// @title A simple wallet contract receiving ether
/// @author @developerasun
/// @dev use Remix low level interaction to send Eth to this contract
// msg.sender ===(send Ether with low level interaction)===> contract receiving the Ether
// msg.sender <===(withdraw Ether)=== contract withdrawing the Ether
// sending/receiving account/function should be payable type.

contract EtherWallet {
    address payable public owner;
    constructor() {
        owner = payable(msg.sender);
    }

    // note that receive is declared without 'function keyword'
    // receive function must conform to below format(no params, external and payable)
    // either receive or fallback should be in contract to receive ether
    receive() external payable {}

    // extract Eths that are in contract
    function withdraw(uint256 _amount) external payable {
        require(msg.sender == owner, "only owner");

        // msg.sender sends _amount of ether to this contract
        owner.transfer(_amount);
    }

    function getBalance() external view returns(uint256) {
        return address(this).balance;
    }
}