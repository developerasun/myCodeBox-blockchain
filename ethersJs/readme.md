# Learning Ethers.js essentials

> The ethers.js library aims to be a complete and compact library for interacting with the Ethereum Blockchain and its ecosystem. It was originally designed for use with ethers.io and has since expanded into a more general-purpose library.

1. Keep your private keys in your client, safe and sound
1. Import and export JSON wallets (Geth, Parity and crowdsale)
1. mport and export BIP 39 mnemonic phrases (12 word backup phrases) and HD Wallets (English, Italian, Japanese, Korean, Simplified Chinese, Traditional Chinese; more coming soon)
1. Meta-classes create JavaScript objects from any contract ABI, including ABIv2 and Human-Readable ABI
1. Connect to Ethereum nodes over JSON-RPC, INFURA, Etherscan, Alchemy, Cloudflare or MetaMask.
1. ENS names are first-class citizens; they can be used anywhere an Ethereum addresses can be used
1. Tiny (~88kb compressed; 284kb uncompressed)
1. Complete functionality for all your Ethereum needs
1. Extensive documentation
1. Large collection of test cases which are maintained and added to
1. Fully TypeScript ready, with definition files and full TypeScript source
1. MIT License (including ALL dependencies); completely open source to do with as you please

## Getting started

Install ethers.js.

```shell
$npm i ethers
```

> Provider: A Provider (in ethers) is a class which provides an abstraction for **a connection to the Ethereum Network**. It provides **read-only** access to the Blockchain and its status.
> Signer: A Signer is a class which (usually) in some way directly or indirectly has access to a private key, which can sign messages and transactions to authorize the network to charge your account ether to perform operations.
> Contract: A Contract is an abstraction which represents a connection to a specific contract on the Ethereum Network, so that applications can use it like a normal JavaScript object.

### Connecting to Ethereum: MetaMask

> The quickest and easiest way to experiment and begin developing on Ethereum is to use MetaMask, which is a browser extension that provides:

- A connection to the Ethereum network (a Provider)
- Holds your private key and can sign things (a Signer)

### Connecting to Ethereum: RPC

> The JSON-RPC API is another popular method for interacting with Ethereum and is available in all major Ethereum node implementations (e.g. Geth and Parity) as well as many third-party web services (e.g. INFURA). It typically provides:

- A connection to the Ethereum network (a Provider)
- Holds your private key and can sign things (a Signer)

#### Querying the Blockchain

> Once you have a **Provider**, you have a read-only connection to the blockchain, which you can **use to query the current state**, fetch historic logs, look up deployed code and so on.

```js
// A Web3Provider wraps a standard Web3 provider, which is
// what MetaMask injects as window.ethereum into each page
const provider = new ethers.providers.Web3Provider(window.ethereum)

// MetaMask requires requesting permission to connect users accounts
await provider.send('eth_requestAccounts', [])

// The MetaMask plugin also allows signing transactions to
// send ether and pay to change state within the blockchain.
// For this, you need the account signer...
const signer = provider.getSigner()
```

### Provider

> A Provider is an abstraction of a connection to the Ethereum network, providing a concise, consistent interface to standard Ethereum node functionality. The ethers.js library provides several options which should cover the vast majority of use-cases, but also includes the necessary functions and classes for sub-classing if a more custom configuration is necessary. **Most users should use the Default Provider**.

> The default provider is the safest, easiest way to begin developing on Ethereum, and it is also robust enough for use in production.

> It creates a FallbackProvider connected to as many backend services as possible. When a request is made, it is sent to multiple backends simultaneously. As responses from each backend are returned, they are checked that they agree. Once a quorum has been reached (i.e. enough of the backends agree), the response is provided to your application.

> This ensures that if a backend has become out-of-sync, or if it has been compromised that its responses are dropped in favor of responses that match the majority.

```js
// The options is an object, with the following properties:
// alchemy, etherscan, infura
ethers.getDefaultProvider( network, option ) => Provider
```

<details>
<summary>API keys</summary>

> It is highly recommended for production services to acquire and specify an API Key for each service. The default API Keys used by ethers are shared across all users, so services may throttle all services that are using the default API Keys during periods of load without realizing it.

> Many services also have monitoring and usage metrics, which are only available if an API Key is specified. This allows tracking how many requests are being sent and which methods are being used the most. Some services also provide additional paid features, which are only available when specifying an API Key.

</details>

### Network

> There are several official common Ethereum networks as well as custom networks and other compatible projects. Any API that accept a Networkish can be passed a common name (such as "mainnet" or "ropsten") or chain ID to use that network definition or may specify custom parameters.

```js
ethers.getNetwork('homestead')
// By Chain Name
// {
//   chainId: 1,
//   ensAddress: '0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e',
//   name: 'homestead'
// }

ethers.getNetwork(1)
// By Chain ID
// {
//   chainId: 1,
//   ensAddress: '0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e',
//   name: 'homestead'
// }
```

### Signer

> A Signer in ethers is an abstraction of an Ethereum Account, which can be used to sign messages and transactions and send signed transactions to the Ethereum Network to execute state changing operations. The available operations depend largely on the sub-class used.

> For example, a Signer from MetaMask can send transactions and sign messages but cannot sign a transaction (without broadcasting it). The most common Signers you will encounter are:

- Wallet, which is a class which knows its private key and can execute any operations with it
- JsonRpcSigner, which is connected to a JsonRpcProvider (or sub-class) and is acquired using getSigner

> The Signer class is abstract and cannot be directly instantiated. Instead use one of the concrete sub-classes, such as the Wallet, VoidSigner or JsonRpcSigner.

```js
// Sub-classes must implement this, however they may simply throw an error if changing providers is not supported.
signer.connect( provider ) ⇒ Signer

// Returns a Promise that resolves to the account address.
// This is a Promise so that a Signer can be designed around an asynchronous source, such as hardware wallets. Sub-classes must implement this.
signer.getAddress( ) ⇒ Promise< string< Address >

// Returns true if and only if object is a Signer.
Signer.isSigner( object ) ⇒ boolean

```

## Contract interaction

> A Contract object is an abstraction of a contract (EVM bytecode) deployed on the Ethereum network. It allows for a simple way to serialize calls and transactions to an on-chain contract and deserialize their results and emitted logs. A ContractFactory is an abstraction of a contract's bytecode and facilitates deploying a contract.

> A Contract is an abstraction of code that has been deployed to the blockchain. A Contract may be sent transactions, which will trigger its code to be run with the input of the transaction data.

```js
new ethers.Contract( address , abi , signerOrProvider )
// Returns a new instance of the Contract attached to a new address. This is useful if there are multiple similar or identical copies of a Contract on the network and you wish to interact with each of them.
contract.attach( addressOrName ) ⇒ Contractsource

// Returns a new instance of the Contract, but connected to providerOrSigner.
// By passing in a Provider, this will return a downgraded Contract which only has read-only access (i.e. constant calls).
// By passing in a Signer. this will return a Contract which will act on behalf of that signer.
contract.connect( providerOrSigner ) ⇒ Contractsource
```

### Meta-Class

> A Meta-Class is a Class which has any of its properties determined at run-time. The Contract object uses a Contract's ABI to determine what methods are available, so the following sections describe the generic ways to interact with the properties added at run-time during the Contract constructor.

#### Read-Only Methods (constant)

> A constant method (denoted by pure or view in Solidity) is read-only and evaluates a small amount of EVM code against the current blockchain state and can be computed by asking a single node, which can return a result. It is therefore free and does not require any ether, but cannot make changes to the blockchain state..

#### Write Methods (non-constant)

> A non-constant method requires a transaction to be signed and requires payment in the form of a fee to be paid to a miner. This transaction will be verified by every node on the entire network as well by the miner who will compute the new state of the blockchain after executing it against the current state.

> It cannot return a result. If a result is required, it should be logged using a Solidity event (or EVM log), which can then be queried from the transaction receipt.

#### Event filter

> An event filter is made up of topics, which are values logged in a Bloom Filter, allowing efficient searching for entries which match a filter.

```js
// Return a filter for EVENT_NAME, optionally filtering by additional constraints.
contract.filters.EVENT_NAME( ...args ) ⇒ Filter
```

> Only indexed event parameters may be filtered. If a parameter is null (or not provided) then any value in that field matches.

## BigNumber

> Many operations in Ethereum operate on numbers which are outside the range of safe values to use in JavaScript. A BigNumber is an object which safely allows mathematical operations on numbers of any magnitude. Most operations which need to return a value will return a BigNumber and parameters which accept values will generally accept them.

### Why can't I just use numbers?

> The first problem many encounter when dealing with Ethereum is the concept of numbers. Most common currencies are broken down with very little granularity. For example, there are only 100 cents in a single dollar. However, there are 1018 wei in a single ether.

> JavaScript uses IEEE 754 double-precision binary floating point numbers to represent numeric values. As a result, there are holes in the integer set after 9,007,199,254,740,991; which is problematic for Ethereum because that is only around 0.009 ether (in wei), which means any value over that will begin to experience rounding errors.

> To demonstrate how this may be an issue in your code, consider:

```js
Number.MAX_SAFE_INTEGER + 2 - 2 == Number.MAX_SAFE_INTEGER
// false
```

> To remedy this, all numbers (which can be large) are stored and manipulated as Big Numbers. The functions parseEther( etherString ) and formatEther( wei ) can be used to convert between string representations, which are displayed to or entered by the user and Big Number representations which can have mathematical operations handled safely.

## Creating Instances

> The constructor of BigNumber cannot be called directly. Instead, Use the static BigNumber.from.

```js
ethers.BigNumber.from( aBigNumberish ) ⇒ BigNumber
```

## Reference

- [Ethers js official docs](https://docs.ethers.io/v5/)
