# Learning Solana essentials
## Basics
> Solana is an open source project implementing a new, high-performance, permissionless blockchain. The Solana Foundation is based in Geneva, Switzerland and maintains the open source project.

> It is possible for a centralized database to process 710,000 transactions per second on a standard gigabit network if the transactions are, on average, no more than 176 bytes. A centralized database can also replicate itself and maintain high availability without significantly compromising that transaction rate using the distributed system technique known as Optimistic Concurrency Control [H.T.Kung, J.T.Robinson (1981)]. 

> At Solana, we are demonstrating that these same theoretical limits apply just as well to blockchain on an adversarial network. The key ingredient? Finding a way to share time when nodes cannot rely upon one another. Once nodes can rely upon time, suddenly ~40 years of distributed systems research becomes applicable to blockchain!

> Therefore, our method is used to implement a kernel that performs the necessary synchronization--for example, making sure that two different processes do not try to modify a file at the same time. Processes might spend only a small fraction of their time executing the synchronizing kernel; the rest of the time, they can operate independently--e.g., accessing different files. This is an approach we have advocated even when fault-tolerance is not required. 

### Cluster
> A cluster is a set of computers that work together and can be viewed from the outside as a single system. A Solana cluster is a set of independently owned computers working together (and sometimes against each other) to verify the output of untrusted, user-submitted programs. A Solana cluster can be utilized any time a user wants to preserve an immutable record of events in time or programmatic interpretations of those events. 

> One use is to track which of the computers did meaningful work to keep the cluster running. Another use might be to track the possession of real-world assets. In each case, the cluster produces a record of events called the ledger. It will be preserved for the lifetime of the cluster. As long as someone somewhere in the world maintains a copy of the ledger, the output of its programs (which may contain a record of who possesses what) will forever be reproducible, independent of the organization that launched it.

### Native token
> A SOL is the name of Solana's native token, which can be passed to nodes in a Solana cluster in exchange for running an on-chain program or validating its output. The system may perform micropayments of fractional SOLs, which are called lamports. They are named in honor of Solana's biggest technical influence, Leslie Lamport. A lamport has a value of 0.000000001 SOL.

## Terminology
> lamport : A fractional native token with the value of 0.000000001 sol.

more will be added

## Solana program library
> The Solana Program Library (SPL) is a collection of on-chain programs targeting the Sealevel parallel runtime. These programs are tested against Solana's implementation of Sealevel, solana-runtime, and deployed to its mainnet. As others implement Sealevel, we will graciously accept patches to ensure the programs here are portable across all implementations.

### Token program 
> The Token Program is written in Rust and available on crates.io and docs.rs. Auto-generated C bindings are also available. JavaScript bindings are available that support loading the Token Program on to a chain and issue instructions.

## Reference
- [Solana official docs](https://docs.solana.com/developing/programming-model/overview)
- [Create Solana Tokens and NFT](https://www.youtube.com/watch?v=L4WWQzOBNIg)
