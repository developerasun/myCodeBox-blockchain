// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract MyFunction {
    uint256 myState = 256; 
    uint8 myAge = 27;
    string name = "Jake";

    // Functions can be declared pure in which case they promise 
    // not to read from or modify the state.
    function myPureFunc(uint256 x, uint256 y) public pure returns(uint256){
        return x + y;
    }

    function myViewFunc() public view returns(string memory) {
        return name;
    }

    function secretlyReturnGreeting() private pure returns(string memory) {
        return "Hello Anna";
    }

    function myUpdateFunc() public returns(string memory){ 
        string memory secretString = secretlyReturnGreeting(); // private function can get called inside contract.
        name = secretString;
        return name;
    }

    // External function can only get executed outside contract
    function myExternalFunc() external{
        myAge = 50;
    }

    // function can return multiple values
    function myMultipleReturnFunc() public pure returns(uint8, string memory) {
        return (8, "hello"); // wrap return values with parenthesis
    }
}

contract MySelector {
    event Log(bytes data);

    function transfer(address _to, uint _amount) external {
        emit Log(msg.data);
                // msg.data is divided as follows
        // 1) 0xa9059cbb: a function selector, the first four bytes encode the function to call
        // 2) 000000000000000000000000ab8483f64d9c6d1ecf9b849ae677dd3315835cb2: the value of param 1 address(_to)
        // the address value copied from Remix: 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
        // 3) 000000000000000000000000000000000000000000000000000000000000000b: the value of param 2 uint(_amount)
        // the amount value entered by user: 11
        // : function parameters to pass
    }
}

contract FunctionSelector {
    // example: "transfer(address,uint256)"
    // note that enter no white space between parameters(hash value changes)
    function GetSelector(string calldata functionSignature) external pure returns (bytes4) {
        // string => dynamic byte array => bytes32 ====(truncating)====> bytes4
        return bytes4(keccak256(bytes(functionSignature)));
    }
}