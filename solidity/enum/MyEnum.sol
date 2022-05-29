// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyEnum {
    // 0, 1, 2
    enum Rarity {
        original,
        rare, 
        superRare
    }

    Rarity public rarity;
    
    constructor() {
        initSetup();
    }

    function initSetup() private {
        rarity = Rarity.original; // default rarity is rare.
    }

    function makeRare() public {
        rarity = Rarity.rare;
    }
    
    function getCurrentRarity() public view returns(Rarity) {
        return rarity;
    }
}

