// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


/// @title error handling types in Solidity
/// @author @developerasun

contract MyError {
    // three ways to validate data in Solidity before execution 
    // 1) require: 
    // 2) revert:   
    // 3) assert: 
    function myPureFunc(uint8 _x, uint8 _y) public pure returns(uint8){
        
        // the code block stops and evaluate if this is true. If true, continue.
        require(_x > _y, "x should be bigger than y"); 
        return _x + _y ;
    }

    function useRevert(uint8 _x, uint8 _y) public pure returns(uint8){
        if (_x == 10) {
            revert("x can't be 10");
        }
        if (_y == 20) {
            revert("y can't be 20");
        }
        return _x + _y;
    }

    function useExternal() external pure returns(uint) {
        return 5;
    }
}

/// @notice get external function call and do error handling with try~catch statement
contract MyTryCatch {
    uint256 changeMe = 1;
    uint256 tryNumber = 3;

    // events divided for each catch block
    event StringFailure(string stringFailure);
    event BytesFailure(bytes bytesFailure);
    event UintFailure(uint uintFailure); 

    function check(address _contract) public returns(bool success) {
        MyError me = MyError(_contract);

        // try~catch is used for external function call or contract creation
        try me.useExternal() returns(uint){ // clarifying return type is optional
            require(tryNumber > 0, "No longer valid");
            changeMe = 55;
            tryNumber = tryNumber -1;
            return true;
        } catch Error(string memory _err){
            // This is executed in case
            // revert was called inside getData
            // and a reason string was provided.
            // Event invocations have to be prefixed by "emit".
            emit StringFailure(_err);
            return false;
        } 

        // use a corresponding catch block with try. 
        // catch Panic(uint _errCode) {
        //     // This is executed in case of a panic,
        //     // i.e. a serious error like division by zero
        //     // or overflow. The error code can be used
        //     // to determine the kind of error.
        //     emit UintFailure(_errCode);
        //     return false;
        // } catch (bytes memory _lowLevelData) {
        //     // This is executed in case revert() was used.
        //     // revert does not have an error message unlike require.
        //     emit BytesFailure(_lowLevelData);
        //     return false;
        // }
    }

    function getChangeMe() public view returns(uint) {
        return changeMe;
    }

    function getTryNumber() public view returns(uint) {
        return tryNumber;
    }
}