// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

/*
delegatecall: This means that a contract can dynamically load code 
from a different address at runtime. Storage, current address and 
balance still refer to the calling contract, only the code is taken
from the called address.
 */

contract TestMyDelegateCall {
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _nums) external payable {
        num = _nums;
        sender = msg.sender;
        value = msg.value;
    }
}

contract MyDelegateCall {
    // when trying to update contract logic with delegatecall, 
    // the layout of state variable should be the same in the two contract.
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(address _test, uint256 _num) external payable {
        // option A: with function signature
        // _test.delegatecall(abi.encodeWithSignature("setVars(uint256)"), _num);

        // option B: with function selector
        (bool success, ) = _test.delegatecall(abi.encodeWithSelector(TestMyDelegateCall.setVars.selector, _num));
        require(success, "delegatecall failed");
    }

    function getSelector() public pure returns (bytes4) {
        return TestMyDelegateCall.setVars.selector;
    }
}