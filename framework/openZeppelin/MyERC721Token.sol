// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "./node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "./node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import "./node_modules/@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

contract MyERC721Token is ERC721, ERC721Burnable, ERC721Pausable, ERC721Holder{
    constructor()ERC721("MYERC721TOKEN", "MY721"){}

    // override burn function from ERC721Burnable
    function burn(uint256 amount) public override{
        burn(amount);
    }

    // _beforeTokenTransfer should be overriden from ERC721Pausable
    function _beforeTokenTransfer(address from,
        address to,
        uint256 tokenId)internal virtual override(ERC721, ERC721Pausable) {
            super._beforeTokenTransfer(from, to, tokenId);
            require(!paused(), "ERC721Pausable: token transfer while paused");
        }

    // now this contract can receive ERC721 token(ERC721 compatible)
    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory) public virtual override returns (bytes4) {
            return this.onERC721Received.selector;
        }

} 