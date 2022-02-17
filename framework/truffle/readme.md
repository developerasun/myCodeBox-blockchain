# Learning Truffle essentials
## Truffle
> A world class development environment, testing framework and asset pipeline for blockchains using the Ethereum Virtual Machine (EVM), aiming to make life as a developer easier. With Truffle, you get:

1. Built-in smart contract compilation, linking, deployment and binary management.
1. Automated contract testing for rapid development.
1. Scriptable, extensible deployment & migrations framework.
1. Network management for deploying to any number of public & private networks.
1. Package management with EthPM & NPM, using the ERC190 standard.
1. Interactive console for direct contract communication.
1. Configurable build pipeline with support for tight integration.
1. External script runner that executes scripts within a Truffle environment.

### Install and setup
Install truffle and check version like below.

```shell
$npm install -g truffle
$truffle --version
```

And then initialize your truffle project like below.

```shell
$truffle init
```

Truffle provides boilerplate codes.

<img src="../../reference/truffle-init.png" width=264 height=164 alt="truffle project direcotory" />

Adjust truffle-compile.js file for compiler setting, 

```js
  compilers: {
      solc: {
      version: "^0.8.10",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      optimizer: {
        enabled: true,
        runs: 200
      },
      //  evmVersion: "byzantium"
      // }
    }
  },
```

### Compile
Complie your contract with truffle like below. If compiles fine, it will generate build/contracts/~.json files. 

```shell
$truffle compile
```

The json files can be used for later Ethereum blockchain deployment. 

### Deploy and migrate to Truffle local node
Once compilation is done, the next thing to do is to deploy the smart contract to blockchain. 

<img src="../../reference/truffle-migration.png" width=300 height=100 alt="truffle migration direcotory" />

Remember to follow naming convention in the directory and 1_initial_migration.js needs to be migrated first. 

```js : 2_hello_world_migration.js
const HelloWorld = artifacts.require("HelloWorld");

module.exports = function (deployer) {
  deployer.deploy(HelloWorld);
};
```

If none of external blockchain is connected, local Ethereum nodes will be used for deployment.

```shell
# get local Ethereum node
$truffle develop 

# deploy to the node
$truffle migrate
```

Check local dummy Ethereum nodes. 

<img src="../../reference/truffle-local-dummy-account.png" width=565 height=363 alt="truffle local nodes" />

Check migration.

<img src="../../reference/truffle-migrate.png" width=611 height=169 alt="truffle migrate" />

### Test
> Truffle uses the Mocha testing framework and Chai for assertions to provide you with a solid framework from which to write your JavaScript tests.

#### Use contract() instead of describe()¶
> Structurally, your tests should remain largely unchanged from that of Mocha: Your tests should exist in the ./test directory, they should end with a .js extension, and they should contain code that Mocha will recognize as an automated test. What makes Truffle tests different from that of Mocha is the contract() function: This function works exactly like describe() except it enables Truffle's clean-room features. It works like this:

> Before each contract() function is run, your contracts are redeployed to the running Ethereum client so the tests within it run with a clean contract state.

> The contract() function provides a list of accounts made available by your Ethereum client which you can use to write tests.
Since Truffle uses Mocha under the hood, you can still use describe() to run normal Mocha tests whenever Truffle clean-room features are unnecessary.

#### Use contract abstractions within your tests¶
> Contract abstractions are the basis for making contract interaction possible from JavaScript (they're basically our flux capacitor). Because Truffle has no way of detecting which contracts you'll need to interact with within your tests, you'll need to ask for those contracts explicitly. 

> You do this by using the artifacts.require() method, a method provided by Truffle that allows you to request a usable contract abstraction for a specific Solidity contract. As you'll see in the example below, you can then use this abstraction to make sure your contracts are working properly.

#### Using web3¶
A web3 instance is available in each test file, configured to the correct provider. So calling web3.eth.getBalance just works!

```js
it('should return 1 ether', async () => {
  let instance = await HelloWorld.deployed()
    assert.equal(web3.utils.fromWei('1000000000000000000', 'ether'), '1')
})
```

### Deploy to Mainnet/Testnet
In order to deploy your contract to Mainnet, what is needed is a blockchain node so that Mainnet node can update transactions when your node emits the transaction. 

Install your Ethereum node at [Moralis](https://moralis.io/)

When deploying the contract to Mainnet, it requires gas fee. 

1. Create a dummy mnemonics like below. 

```shell
# create dummy mnemonics
# e.g wink cream attack roof guitar balcony memory panel print cause aim warrior
$npx mnemonics 
```

2. Install @truffle/hdwallet-provider. 

```shell
$npm i @truffle/hdwallet-provider
```

3. Access Ropsten testnet by Truffle console and get fake accounts.  

```shell
$truffle console --network ropsten
```

<img src="../../reference/truffle-get-accounts.png" width=436 height=348 alt="getting ropsten fake accounts with web3" />

4. Charge fake ether from [faucet](https://faucet.egorfine.com/)

And then adjust a few options in truffle-config.js file. 

```js
const HDWalletProvider = require('@truffle/hdwallet-provider');

// secerts.json contains blockchain node api url and mnemonics. 
const mnemonic = require('./secrets.json').mnemonics
const moralisEthNode = require('./secrets.json').moralisEthNode

const networksOption = {
  // some other options

      ropsten: {
        provider: () => new HDWalletProvider(mnemonic, moralisEthNode),
      network_id: 3,       // Ropsten's id
      gas: 5500000,        // Ropsten has a lower block limit than mainnet
      confirmations: 2,    // # of confs to wait between deployments. (default: 0)
      timeoutBlocks: 200,  // # of blocks before a deployment times out  (minimum/default: 50)
      skipDryRun: true     // Skip dry run before migrations? (default: false for public nets )
    },
}

```

Once all configured, run migrate command in Truffle console. Each migration will be paused as much as your confirmations options in truffle-config.js.  

```shell
$truffle migrate 
```

Note that the migration takes some time with the confirmations. 

<img src="../../reference/deploy-hello-world.png" width=615 height=468 alt="hello world contract deployment" />

Check the result [ropsten etherscan](https://ropsten.etherscan.io/).

<img src="../../reference/ropsten-etherscan-result.png" width=708 height=648 alt="deployed contract in ropsten etherscan" />

## Getting started with Truffle
A directory of truffle project is as follows : 

1. contracts/: Directory for Solidity contracts
1. migrations/: Directory for scriptable deployment files
1. test/: Directory for test files for testing your application and contracts
1. truffle-config.js: Truffle configuration file

> Truffle also requires that you have a running Ethereum client which supports the standard JSON RPC API (which is nearly all of them). There are many to choose from, and some better than others for development

### Compiling contracts
> With a bare Truffle project (created through truffle init), you're given a single Migrations.sol file that helps in the deployment process. If you're using a Truffle Box, you will have multiple files here.

```shell
$truffle init
```

> To compile a Truffle project, change to the root of the directory where the project is located and then type the following into a terminal:

```shell
$truffle compile # only compiles changed contracts since last compile
$truffle compile --all # compile all contracts 
```

### Build artifacts
> The name of the generated artifact .json files do not reflect the name of the source file but of the name of the contract definition. This means that changing the contract name string in the artifacts.require method to match that of the source file may lead to a Error: Could not find artifacts for {yourContract} from any sources if the contained smart contract definition is named differently.

> You should not edit these artifacts files.

### Interacting with your contracts
> The Ethereum network makes a distinction between writing data to the network and reading data from it, and this distinction plays a significant part in how you write your application. In general, writing data is called a transaction whereas reading data is called a call. Transactions and calls are treated very differently, and have the following characteristics.

#### Transaction
> Transactions fundamentally change the state of the network. ... The defining characteristic of a transaction is that it writes (or changes) data. Transactions cost Ether to run, known as "gas", and transactions take time to process. 

> When you execute a contract's function via a transaction, you cannot receive that function's return value because the transaction isn't processed immediately. 

> In general, functions meant to be executed via a transaction will not return a value; they will return a transaction id instead. So in summary, transactions:

#### Call
> Calls are free to run(not costing gas), and their defining characteristic is that they read data. When you execute a contract function via a call you will receive the return value immediately.

### Contract abstraction
> Contract abstractions are the bread and butter of interacting with Ethereum contracts from Javascript. In short, contract abstractions are wrapper code that makes interaction with your contracts easy, in a way that lets you forget about the many engines and gears executing under the hood. 

> Truffle uses its own contract abstraction via the @truffle/contract module.

```js 
// in truffle console, 
truffle(develop)> let instance = await MetaCoin.deployed()
truffle(develop)> instance

// outputs:
// Contract
// - address: "0xa9f441a487754e6b27ba044a5a8eb2eec77f6b92"
// - allEvents: ()
// - getBalance: ()
// - getBalanceInEth: ()
// - sendCoin: ()
```

> Notice that the abstraction contains the exact same functions that exist within our contract. It also contains an address which points to the deployed version of the MetaCoin contract.






## Reference
- [Moralis Web3 : Truffle Programming Tutorial for Beginners](https://www.youtube.com/watch?v=ZaqAwOzEiQ8&list=PLFPZ8ai7J-iQAtjGbmgcQWfAB53dZvn1y&index=1)
- [Truffle suite](https://trufflesuite.com/docs/truffle/)
- [Truffle suite : getting started](https://trufflesuite.com/docs/truffle/getting-started/installation.html)
- [Writing Tests in Javascript](https://trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript.html)