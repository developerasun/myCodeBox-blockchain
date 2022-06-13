// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "./node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "./node_modules/@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "./node_modules/@openzeppelin/contracts/access/AccessControl.sol";

// match file name and contract name(convention, gas tip)
contract MyERC20Token is ERC20, ERC20Capped, ERC20Pausable, AccessControl {

    // ERC20Capped(1000) => immutable, set token supply to 1000, set during construction time
    constructor()ERC20("MyERC20", "MYERC20Symbol") ERC20Capped(1000){}

    // destroy some amount of tokens
    function burn(address _to, uint256 _amount) public {
        _burn(_to, _amount);
    }

    // _mint should be overriden :  ERC20, ERC20Capped 
    function _mint(address _to, uint256 _amount) internal override(ERC20, ERC20Capped)  {
        _mint(_to, _amount);
    }
    
    // _beforeTokenTransfer should be overriden :  ERC20, ERC20Capped 
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override(ERC20, ERC20Pausable) {
        super._beforeTokenTransfer(from, to, amount);
        require(true, "ERC20Pausable: token transfer while paused");
    }


}