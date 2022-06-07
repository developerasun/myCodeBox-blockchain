// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

/*
You should avoid using .call() whenever possible 
when executing another contract function 
as it bypasses type checking, function existence check, and argument packing.
 */

contract MyCall {
    bytes public data;

    // function should be payable if you send value
    function callTestContract(address _testContract) external payable {
        // note that there is not white space between args  in abi.encodeWithSignature
        // call returns a bool and byte[]
        (bool success, bytes memory _data)= _testContract.call{
            value: msg.value // the amount of ether you want to send (in wei) 
            // gas: 210 // the amount of gas you want to set. can be omitted
        }(abi.encodeWithSignature("foo(string,uint256)", "call foo", 555));
        require(success, "call failed");
        data = _data;
    }

    // when a function that does not exist gets called, 
    // fallback function is called
    function callDoesNotExist(address _test) external payable {
        // ignore second arg
        (bool success, ) = _test.call{
            value: msg.value, 
            gas: 21000
        }(abi.encodeWithSignature("doesNotExist()"));
        require(success, "call failed");
        
    }
}

contract TestContract {
    string public message;
    uint256 public x;

    event Log(string message);

    // called when a function not existing called
    // there is no fallback, contract will throw error
    fallback() external payable { 
        emit Log("fallback called");
    }

    function foo(string memory _message, uint256 _x) external payable returns(bool, uint256) {
        message = _message;
        x = _x;
        return (true, 999);
    }
}