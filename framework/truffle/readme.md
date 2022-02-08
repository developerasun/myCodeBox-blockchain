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

and complie your contract with truffle like below. If compiles fine, it will generate build/contracts/~.json files. 

```shell
$truffle compile
```

The json files can be used for later Ethereum blockchain deployment. 

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


## Reference
- [Moralis Web3 : Truffle Programming Tutorial for Beginners](https://www.youtube.com/watch?v=ZaqAwOzEiQ8&list=PLFPZ8ai7J-iQAtjGbmgcQWfAB53dZvn1y&index=1)
- [Truffle suite](https://trufflesuite.com/docs/truffle/)