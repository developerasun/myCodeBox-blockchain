# Learning web 3 essentials
## What is Web3?
Web3.js is a Javascript library for Ethereum. 

> This is the Ethereum **JavaScript API** which connects to the Generic **JSON-RPC** spec. You need to run a local or remote Ethereum node to use this library.

> Web3.js is a collection of libraries that allow you to interact with a local or remote ethereum node using HTTP, IPC or WebSocket.

> To **talk to an ethereum node from inside a JavaScript application** use the web3.js library, which gives a convenient interface for the RPC methods.

## Installation 
Install web3.js with below command. 

```shell
$npm i web3
```

## Architecture
Overall structure for web3.js to communicate with Ethereum blockchain is as follows : 

<img src="reference/web3-ethereum-structure.png" width=1000 height=500 alt="web3 and ethereum" /> 

Web3 needs a Provider, which is responsible for sending actual API calls to Ethereum blockchain on behalf of Web3.

<img src="reference/web-provider.png" width=676 height=438 alt="web3 provider structure" /> 

By having a separate provider, user can choose whatever wallet they would like to use. 

<img src="reference/wallet-provider-dapp.png" width=555 height=281 alt="dapp and provider structure" /> 

## Provider
1. Infura
Infura is a **blockchain toolkit platform** that connect you to blockchain(in this tutorial case, Ethereum) node over **JSON-RPC**. Sign up and create a project to network API key to access blockchain.

```js
import web3 from 'web3'
console.dir(web3)

const infuraAPI = 'API_KEY_HERE'
const myWeb3 = new web3(infuraAPI)

console.log(myWeb3)
```

2. Ganache
You can use a local Ethereum blockchain using Ganache. 

> **Ganache is a personal blockchain** for rapid Ethereum and Corda distributed application development. You can use Ganache across the entire development cycle; enabling you to develop, deploy, and test your dApps in a safe and deterministic environment.
> The command-line tool, ganache-cli (formerly known as the **TestRPC**), is available for Ethereum development.

## Interact with smart contract
In order to interact with smart contract in dapp, Web3 instance needs to know what contract it interacts with. 

<img src="reference/web3-contract-smartcontract.png" width=521 height=627 alt="web3 smart contract interaction" /> 

Thus, you should provide 

1. contract address
1. contract ABI(JSON document describing smart contract interface)

## ABI
Applicaiton Binary Interface is explained like below.

> The Contract Application Binary Interface (ABI) is the **standard way to interact with contracts in the Ethereum ecosystem**, both from outside the blockchain and for contract-to-contract interaction. **Data is encoded according to its type, as described in this specification**. The encoding is not self describing and thus requires a schema in order to decode.

Code example of ABI is as follows. It's from Etherscan MekaApes Game contract. 

```json
[{"inputs":[{"internalType":"address","name":"_logic","type":"address"},{"internalType":"address","name":"admin_","type":"address"},{"internalType":"bytes","name":"_data","type":"bytes"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"address","name":"previousAdmin","type":"address"},{"indexed":false,"internalType":"address","name":"newAdmin","type":"address"}],"name":"AdminChanged","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"beacon","type":"address"}],"name":"BeaconUpgraded","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"implementation","type":"address"}],"name":"Upgraded","type":"event"},{"stateMutability":"payable","type":"fallback"},{"inputs":[],"name":"admin","outputs":[{"internalType":"address","name":"admin_","type":"address"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newAdmin","type":"address"}],"name":"changeAdmin","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"implementation","outputs":[{"internalType":"address","name":"implementation_","type":"address"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newImplementation","type":"address"}],"name":"upgradeTo","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"newImplementation","type":"address"},{"internalType":"bytes","name":"data","type":"bytes"}],"name":"upgradeToAndCall","outputs":[],"stateMutability":"payable","type":"function"},{"stateMutability":"payable","type":"receive"}]
```

## Transaction
Anything that uses **data in Ethereum triggers a transaction, which costs a gas fee**. Once transaction gets triggered, it will broadcast to entire ethereum blockchain.

- all transactions in **development kit**(e.g Ganache), accounts are **unlocked**(no sign, no private key required)
- In real blockchain, transaction should be **_signed_** before broadcasting. 

```js
// account 1 : send 5 ethers to account 2
web3.eth.sendTransaction( { 
    from : account1, 
    to : account2, 
    value : web3.utils.toWei('5', 'ether')
})
```

<img src="reference/ganache-transaction.png" width=818 height=209 alt="ganache transactions" /> 

### Preparation
1. Prepare a fake ether. Use websites like below
- [Ropsten testnet faucet](https://faucet.egorfine.com/)

2. Create a fake account to test. Set address and private key. Use web3.eth method to create dummy account like below. 

```js
web3.eth.accounts.create()
```

### Broadcasting
1. Set transaction details.
2. Broadcast the transaction.

```js
// create a transaction object to set transaction details
const txObject = {
    to : account2,
    // value needs to be in wei, which is the smallest Ethereum unit
    value : web3.utils.toWei('0.01', 'ether'),  // send 0.01 ETH

    // transaction commission threshold
    gas : '21000', 
    gasPrice : web3.utils.toWei('10', 'gwei')
}

// sign the transaction
const signedTransaction = web3.eth.accounts.signTransaction(txObject, PK1)

// broadcast the transaction
signedTransaction.then(signedTx => {
    const sentTx = web3.eth.sendSignedTransaction(signedTx.rawTransaction)
    
    sentTx.on("receipt", receipt => {
        console.log("receipt : ", receipt)
    })
    
    sentTx.on("error", error => {
        console.log("error : ", error)
    })
})
```

3. check result in terminal and ropsten etherscan. 
<img src="reference/transaction-result-log.png" width=800 height=300 alt="ropsten transaction" /> <br/>

<img src="reference/ropsten-test-transaction-result.png" width=640 height=900 alt="ropsten etherscan result" /> 

## Reference
- [Web3.js - Readme](https://github.com/ChainSafe/web3.js/blob/1.x/README.md)
- [web3.js - Ethereum JavaScript API](https://web3js.readthedocs.io/en/v1.7.0/)
- [Dappuniversity - Web3.js · Ethereum Blockchain Developer Crash Course](https://www.youtube.com/playlist?list=PLS5SEs8ZftgXlCGXNfzKdq7nGBcIaVOdN)
- [Eat the block - web3 tutorial](https://youtube.com/playlist?list=PLbbtODcOYIoFs0PDlTdxpEsZiyDR2q9aA)