// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {
    // state variables for 2 tokens, 2 owners
    // owner1 has token1, wanting token 2
    // owner2 has token2, wanting token 1
    IERC20 public token1;
    address public owner1;
    IERC20 public token2;
    address public owner2;

    constructor(
        address _token1,
        address _token2,
        address _owner1,
        address _owner2
    ) {
        token1 = IERC20(_token1);
        token2 = IERC20(_token2);
        owner1 = _owner1;
        owner2 = _owner2;
    }

    function swap(uint256 _amount1, uint256 _amount2) public {
        // restrict function executors
        require(msg.sender == owner1 || msg.sender == owner2, "Not authorized");

        // IERC20.allowance(owner, spender): spender is able to spend on behalf of owner
        require(token1.allowance(owner1, address(this)) >= _amount1, "Too many token 1 amounts to swap");
        require(token2.allowance(owner2, address(this)) >= _amount2, "Too many token 2 amounts to swap");

        // send each token to each owner
        _safeTransferFrom(token1, owner1, owner2, _amount1);
        _safeTransferFrom(token2, owner2, owner1, _amount2);
    }

    //  IERC20.transferFrom(sender, recipient, amount): A sends B to C
    function _safeTransferFrom(
        IERC20 _token,
        address _sender,
        address _recipient,
        uint256 _amount
    ) private {
        bool sent = _token.transferFrom(_sender, _recipient, _amount);
        // execute only when above transfer succeeded
        require(sent, "Token transfer failed");
    }
}
