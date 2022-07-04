# Learning Chainlink Oracles

Blockchain, by default, is deterministic. However, random number can be useful for certain smart contracts and we need a way to create it.

To solve this issue, you must use chainlink VRF solution(verifiable random function)

- first transaction: smart contract(on-chain) ====(request with link token<ERC20>)====> chainlink nodes(off-chain)
- second transaction: chainlink nodes(off-chain) ====(receive)====> smart contract(on-chain)

In the first transaction, oracle cost happens.

- oracle cost: link token funds for request, depending on network.
