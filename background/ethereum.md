# Learning Ethereum essetials
## WHAT IS A BLOCKCHAIN?
> A blockchain is a public database that is updated and shared across many computers in a network. **"Block" refers to data and state being stored** in consecutive groups known as "blocks". If you send ETH to someone else, the transaction data needs to be added to a block to be successful.

> **"Chain" refers to the fact that each block cryptographically references its parent**. In other words, blocks get chained together. The data in a block cannot change without changing all subsequent blocks, which would require the consensus of the entire network.

> **Every computer in the network must agree upon each new block and the chain** as a whole. These computers are known as "nodes". Nodes ensure everyone interacting with the blockchain has the same data. To accomplish this distributed agreement, blockchains need a consensus mechanism.

> Ethereum currently uses a proof-of-work consensus mechanism. This means that anyone who wants to add new blocks to the chain must solve a difficult puzzle that requires a lot of computing power. Solving the puzzle "proves" that you have done the "work" by using computational resources. Doing this is known as mining. Mining is typically brute force trial and error, but successfully adding a block is rewarded in ETH.

> New blocks are broadcast to the nodes in the network, checked and verified, thus updating the state of the blockchain for everyone.

> So to summarize, when you send ETH to someone, the transaction must be mined and included in a new block. The updated state is then shared with the entire network.

## WHAT IS ETHEREUM?
> In the Ethereum universe, there is a single, canonical computer (called the Ethereum Virtual Machine, or EVM) whose state everyone on the Ethereum network agrees on. Everyone who participates in the Ethereum network (every Ethereum node) keeps a copy of the state of this computer. Additionally, any participant can broadcast a request for this computer to perform arbitrary computation. Whenever such a request is broadcast, other participants on the network verify, validate, and carry out ("execute") the computation. This execution causes a state change in the EVM, which is committed and propagated throughout the entire network.

> Requests for computation are called transaction requests; the record of all transactions and the EVM's present state gets stored on the blockchain, which in turn is stored and agreed upon by all nodes.

> Cryptographic mechanisms ensure that once transactions are verified as valid and added to the blockchain, they can't be tampered with later. The same mechanisms also ensure that all transactions are signed and executed with appropriate "permissions" (no one should be able to send digital assets from Alice's account, except for Alice herself).


## WHAT IS ETHER?
> Ether (ETH) is **the native cryptocurrency of Ethereum**. The purpose of ether is to allow for a market for computation. Such **a market provides an economic incentive for participants to verify and execute transaction** requests and provide computational resources to the network.

> **Any participant who broadcasts a transaction request must also offer some amount of ether to the network as a bounty**. This bounty will be awarded to whoever eventually does **the work of verifying the transaction**, executing it, committing it to the blockchain, and broadcasting it to the network.

> The amount of ether paid corresponds to the time required to do the computation. These bounties also prevent malicious participants from intentionally clogging the network by requesting the execution of infinite computation or other resource-intensive scripts, as these participants must pay for computation time.

## WHAT ARE SMART CONTRACTS?
> In practice, participants don't write new code every time they want **to request a computation on the EVM**. Rather, application developers upload programs (reusable snippets of code) into EVM state, and users make requests to execute these code snippets with varying parameters. We call the programs uploaded to and executed by the network smart contracts.

> At a very basic level, you can think of **a smart contract like a sort of vending machine**: a script that, when called with certain parameters, performs some actions or computation if certain conditions are satisfied. For example, a simple vendor smart contract could create and assign ownership of a digital asset if the caller sends ether to a specific recipient.

> Any developer can create a smart contract and make it public to the network, using the blockchain as its data layer, for a fee paid to the network. Any user can then call the smart contract to execute its code, again for a fee paid to the network.

> Thus, with smart contracts, developers can build and deploy arbitrarily complex user-facing apps and services such as: marketplaces, financial instruments, games, etc

## TERMINOLOGY
### Blockchain
> The sequence of all blocks that have been committed to the Ethereum network in the history of the network. So-named because each block contains a reference to the previous block, which helps us maintain an ordering over all blocks (and thus over the precise history)

### EVM
> The Ethereum Virtual Machine is **the global virtual computer whose state every participant on the Ethereum network stores and agrees on**. Any participant can request the execution of arbitrary code on the EVM; code execution changes the state of the EVM.

### Nodes
> The real-life machines which are storing the EVM state. Nodes communicate with each other to propagate information about the EVM state and new state changes. Any user can also request the execution of code by broadcasting a code execution request from a node. The Ethereum network itself is the aggregate of all Ethereum nodes and their communications.

### Accounts
> Where ether is stored. Users can initialize accounts, deposit ether into the accounts, and transfer ether from their accounts to other users. Accounts and account balances are stored in a big table in the EVM; they are a part of the overall EVM state.

### Transactions
> A "transaction request" is the formal term for **a request for code execution on the EVM**, and a "transaction" is a fulfilled transaction request and the associated change in the EVM state. Any user can broadcast a transaction request to the network from a node. For the transaction request to affect the agreed-upon EVM state, it must be validated, executed, and "committed to the network" by another node. **Execution of any code causes a state change in the EVM; upon commitment, this state change is broadcast to all nodes in the network**. Some examples of transactions:

1. Send X ether from my account to Alice's account.
1. Publish some smart contract code into EVM state.
1. Execute the code of the smart contract at address X in the EVM, with arguments Y.

### Blocks
> The volume of transactions is very high, so transactions are "committed" in batches, or blocks. Blocks generally contain dozens to hundreds of transactions.

### Smart contracts
> A reusable snippet of code (a program) which a developer publishes into EVM state. Anyone can request that the smart contract code be executed by making a transaction request. **Because developers can write arbitrary executable applications into the EVM (games, marketplaces, financial instruments, etc.) by publishing smart contracts, these are often also called dapps, or Decentralized Apps**.

## Introduction to dapp
> A decentralized application (dapp) is an application built on a decentralized network that combines a smart contract and a frontend user interface. On Ethereum, smart contracts are accessible and transparent – like open APIs – so your dapp can even include a smart contract that someone else has written. 

### DEFINITION OF A DAPP
> **A dapp has its backend code running on a decentralized peer-to-peer network**. Contrast this with an app where the backend code is running on centralized servers.

> A dapp can have frontend code and user interfaces written in any language (just like an app) to make calls to its backend. Furthermore, its frontend can get hosted on decentralized storage such as IPFS.

1. Decentralized - dapps operate on Ethereum, an open public decentralized platform where no one person or group has control

1. Deterministic - dapps perform the same function irrespective of the environment in which they get executed

1. Turing complete - dapps can perform any action given the required resources

1. Isolated - dapps are executed in a virtual environment known as Ethereum Virtual Machine so that if the smart contract has a bug, it won’t hamper the normal functioning of the blockchain network.

### On smart contracts
> To introduce dapps, we need to introduce smart contracts – a dapp's backend for lack of a better term. For a detailed overview, head to our section on smart contracts.

> **A smart contract is code that lives on the Ethereum blockchain** and runs exactly as programmed. Once smart contracts are deployed on the network you can't change them. **Dapps can be decentralized because they are controlled by the logic written into the contract, not an individual or company**. This also means **you need to design your contracts very carefully and test them thoroughly**.

### BENEFITS OF DAPP DEVELOPMENT
> 



## Synchronization modes
> To follow and verify current data in the network, the Ethereum client needs to sync with the latest network state. This is done by downloading data from peers, cryptographically verifying their integrity, and building a local blockchain database.

> Synchronization modes represent different approaches to this process with various trade-offs. Clients also vary in their implementation of sync algorithms. Always refer to the official documentation of your chosen client for specifics on implementation.

## Overview of strategies
> General overview of synchronization approaches used in Mainnet ready clients:

### Full sync {#full-sync}
Full sync downloads all blocks (including headers, transactions, and receipts) and generates the state of the blockchain incrementally by executing every block from genesis.

Minimizes trust and offers the highest security by verifying every transaction.
With an increasing number of transactions, it can take days to weeks to process all transactions.

### Fast sync
Fast sync downloads all blocks (including headers, transactions, and receipts), verifies all headers, downloads the state and verifies it against the headers.

Relies on the security of the consensus mechanism.
Synchronization takes only a few hours.

### Light sync
Light client mode downloads all block headers, block data, and verifies some randomly. Only syncs tip of the chain from the trusted checkpoint.

Gets only the latest state while relying on trust in developers and consensus mechanism.
Client ready to use with current network state in a few minutes.

### Snap sync
Implemented by Geth. Using dynamic snapshots served by peers retrieves all the account and storage data without downloading intermediate trie nodes and then reconstructs the Merkle trie locally.

Fastest sync strategy developed by Geth, currently its default
Saves a lot of disk usage and network bandwidth without sacrificing security.

### Warp sync
Implemented by OpenEthereum. Nodes regularly generate a consensus-critical state snapshot and any peer can fetch these snapshots over the network, enabling a fast sync from this point.

Fastest and default sync mode of OpenEthereum relies on static snapshots served by peers.
Similar strategy as snap sync but without certain security benefits.
More on Warp

### Beam sync
Implemented by Nethermind and Trinity. Works like fast sync but also downloads the data needed to execute latest blocks, which allows you to query the chain within the first few minutes from starting.

Syncs state first and enables you to query RPC in a few minutes.
Still in development and not fully reliable, background sync is slowed down and RPC responses might fail





## Reference
- [Ethereum.org](https://ethereum.org/en/)