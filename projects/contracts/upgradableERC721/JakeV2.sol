// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

contract JakeV2 is ERC721Upgradeable {
    uint256 public number;
    uint256 public extra;

    function updateNumber(uint256 _number) public {
        number = _number + extra;
    }

    function setExtraNumber(uint256 _extra) public {
        extra = _extra;
    }
}