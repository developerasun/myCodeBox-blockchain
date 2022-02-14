// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Emmet for natspac in VS Code : nat_contract
/// @title Solidity basic operations
/// @author Jake Sung
/// @notice You can learn how solidity function and variable works
/// @dev Check out emmets
contract MyOperator {
    // state variables
    uint8 a = 8; 
    uint8 b = 16; 
    uint8 c = 33;
    uint8 newValue;
    uint8 getA = getter_a();

    /// @notice : read only function(functions with view)
    function getter_a() public view returns (uint8){
        return a;
    }

    /// @notice : assign new value
    function MyCalc2() public  {
        newValue = c % a ; // update the state variable to 1 

        // basic operations 
        b++;
        b += a;
    }

    /// @notice : local scope variable
    function MyLocals() public view {
        bool result = false;
        if (a < b) {
            result = true;
        }
        if (a == b) { 
            result = true;
        }
        if (a != b) {
            result = false;
        }
        if (a < b && c > b) {
            result = false;
        }
    }
    
    function MyIternary() public view {
        uint8 testing = 0;
        newValue > 100 ? testing = 10 : testing = 0;
    }

}