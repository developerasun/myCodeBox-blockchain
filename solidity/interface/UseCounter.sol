// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

// create an interface to interact with a contract that is
// already deployed to network
interface ICounter {
    function count() external view returns(uint256);
    function increment() external;
}

contract UseCounter {
    // note that below inc function will affect the Counter.sol contract's storage.
    // i.e, state varaible number will be increased
    // _counter: Counter.sol's address
    function inc(ICounter _counter) external  {
        ICounter(_counter).increment();
    }

    function getCount(ICounter _counter) external view returns(uint256) {
        return ICounter(_counter).count();
    }
}