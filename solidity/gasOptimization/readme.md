# 10 gas optimization tips

1. limit on-chain data. Solhint recommends to set 15 state variables, maximum
1. use a deployed library.
1. enable compiler optimizer
1. use event for variables which are not intended to read/write from smart contract. event variables consume less gas than state variables.
1. use literal instead of computed values. When you already know a final value of some variables, do not calcualte it in blockchain.
1. avoid to copy arrays in memory. create a storage pointer for array manipulation.
1. avoid for-loop over dynamic ranges. gas fee will increase over time when the dynamic value increases.
1. align the same type variables in order for EVM. EVM stores state variables in memory slot of 256 bits. Types like uint256 fit in one slot and other types are stored over several slots. EVM checks your variables and then try to fit them in one slot if possible and it is only possible when the variables are next to each other.

```solidity
// correct
uint256 one;
uint256 two;
uint128 three;

// incorrect
uint256 one;
uint128 three;
uint256 two;
```

## reference

- [Gas Optimization in Solidity: 10 tips](https://youtu.be/PYilP2bjtwc)
