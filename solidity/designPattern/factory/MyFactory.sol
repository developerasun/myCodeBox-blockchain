// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import './MyTargetV1.sol';

// one parent, multiple children
// cheaper gas(deploy factory contract first and then children)
// improve security
contract MyFactory {
    MyTargetV1[] public v1Array;

    function createTargetContract() public {
        // create a child contract
        MyTargetV1 v1 = new MyTargetV1();

        // register v1 contract
        v1Array.push(v1);
    }

    function createTargetContractWithAddress(address _child) public {
        // create a child contract from address
        MyTargetV1 v1 = MyTargetV1(_child);
        v1Array.push(v1);
    }

    // calling child contract
    function myTargetV1updateMyNum(uint256 _index, uint256 _myNum) public {
        MyTargetV1(address(v1Array[_index])).updateMyNum(_myNum);
        // v1Array[_index].updateMyNum(_myNum); // 31000 gas
    }

    function myTargetV1retrieveMyNum(uint256 _index) public view returns(uint256) {
        return MyTargetV1(address(v1Array[_index])).getMyNum();
    }
}