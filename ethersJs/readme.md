# Learning Ethers.js essentials 
> The ethers.js library aims to be a complete and compact library for interacting with the Ethereum Blockchain and its ecosystem. It was originally designed for use with ethers.io and has since expanded into a more general-purpose library.

- Connect to Ethereum nodes over JSON-RPC, INFURA, Etherscan, Alchemy, Cloudflare or MetaMask.
- Fully TypeScript ready, with definition files and full TypeScript source

## Getting started
Install ethers.js. 

```shell
$npm i ethers
```

> Provider	A Provider (in ethers) is a class which provides an abstraction for a connection to the Ethereum Network. It provides read-only access to the Blockchain and its status.	 
> Signer	A Signer is a class which (usually) in some way directly or indirectly has access to a private key, which can sign messages and transactions to authorize the network to charge your account ether to perform operations.	 
> Contract	A Contract is an abstraction which represents a connection to a specific contract on the Ethereum Network, so that applications can use it like a normal JavaScript object.

## BigNumber
> Many operations in Ethereum operate on numbers which are outside the range of safe values to use in JavaScript. A BigNumber is an object which safely allows mathematical operations on numbers of any magnitude. Most operations which need to return a value will return a BigNumber and parameters which accept values will generally accept them.

### Why can't I just use numbers?
> The first problem many encounter when dealing with Ethereum is the concept of numbers. Most common currencies are broken down with very little granularity. For example, there are only 100 cents in a single dollar. However, there are 1018 wei in a single ether.

> JavaScript uses IEEE 754 double-precision binary floating point numbers to represent numeric values. As a result, there are holes in the integer set after 9,007,199,254,740,991; which is problematic for Ethereum because that is only around 0.009 ether (in wei), which means any value over that will begin to experience rounding errors.

> To demonstrate how this may be an issue in your code, consider:
```js
(Number.MAX_SAFE_INTEGER + 2 - 2) == (Number.MAX_SAFE_INTEGER)
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