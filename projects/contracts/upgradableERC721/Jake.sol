// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract Jake is Initializable, ERC721Upgradeable {
    uint256 public number;

    function initialize(uint256 _number) public initializer {
        number = _number;
        __ERC721_init("JakeNFT", "JK");
    }
}
