// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract MyImmutable {
    // immutable state variable => cost less gas 
    // regular state variable owner: 52601 gas
    // immutable state variable owner: 50149 gas
    address public owner = msg.sender; // set only once during deployment
    uint256 public x;

    function increaseOne() external {
        require(msg.sender == owner);
        x += 1; 
    }

    function changeImmutable() external pure returns(bool) {
        // owner = address(this); // compile error
        revert("hey");
    }
}

contract TryChangeImmutable {
    // set enum for custom error type
    enum errorStatus { ERR_ON_PURPOSE, ERR_UNEXPECTED }

    // custom error type 
    error isImmutable(errorStatus _errorCode, string _errorMessage);

    // custom event for the error type
    event logError(errorStatus indexed _errCode, string _errorMessage);

    function isChangeable() external {
        MyImmutable myImmutable = new MyImmutable();

        // error handling
        try myImmutable.changeImmutable() returns (bool) {
            // require(result == true, "should be true!"); // the "should be true!" string is delivered to below errorMessage.
        } 
        catch Error(string memory errorMessage) {
            // only revert creates an error instance
            emit logError(errorStatus.ERR_ON_PURPOSE, errorMessage);
            revert isImmutable({
                _errorMessage: errorMessage, 
                _errorCode: errorStatus.ERR_ON_PURPOSE
            });
        }
    }
}