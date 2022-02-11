// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract MyContractCall { 
    uint256 public age = 29;     
    function getAge() public view returns(uint256) {
        return age;
    }
}

// If contract address known, and function/state in the contract
// are public, you can call it in your contract
contract MyAnotherContract {
    function getAgeFromAboveContract(address _contractAddress) public view returns(uint256) {
        // create a contract instance : (Contract) (instance name)
        MyContractCall importedContract = MyContractCall(_contractAddress);
        uint256 age = importedContract.getAge();
        return age;
    }
}

contract GroupContracts { 
    function groupExecute(address _myContractCallAddress, address _myAnotherContractAddress) public view {
        MyContractCall mcc = MyContractCall(_myContractCallAddress);
        MyAnotherContract mac = MyAnotherContract(_myAnotherContractAddress);

        // group function call either all succeed or all fail
        mcc.getAge();
        mac.getAgeFromAboveContract(_myContractCallAddress);
    }
}