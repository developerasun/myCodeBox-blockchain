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


## Reference
- [Moralis Web3 : Truffle Programming Tutorial for Beginners](https://www.youtube.com/watch?v=ZaqAwOzEiQ8&list=PLFPZ8ai7J-iQAtjGbmgcQWfAB53dZvn1y&index=1)
- [Truffle suite](https://trufflesuite.com/docs/truffle/)
- [Writing Tests in Javascript](https://trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript.html)