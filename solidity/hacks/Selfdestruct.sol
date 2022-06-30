// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract MySelfdestruct {
    constructor() payable {} // make this contract payable during deployment
    function kill(address _to) external {
        selfdestruct(payable(_to));
    }

    function shouldNotExecute() external pure returns(uint256) {
        return 5;
    }
}

contract Hack {
    // force Hack contract to receive ether without fallback/receive function 
    function getFreeEthers(MySelfdestruct target, address _to) public payable {
        target.kill(_to);
    }
    function getBalance() external view returns(uint256) {
        return address(this).balance;
    }
}