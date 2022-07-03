# Learning Hardhat essentials

> Hardhat is a development environment to compile, deploy, test, and debug your Ethereum software. It helps developers manage and automate the recurring tasks that are inherent to the process of building smart contracts and dApps, as well as easily introducing more functionality around this workflow. This means compiling, running and testing smart contracts at the very core.

> Hardhat comes built-in with Hardhat Network, a local Ethereum network designed for development. Its functionality focuses around Solidity debugging, featuring stack traces, console.log() and explicit error messages when transactions fail.

> Hardhat Runner, the CLI command to interact with Hardhat, is an extensible task runner. It's designed around the concepts of tasks and plugins. Every time you're running Hardhat from the CLI you're running a task. E.g. npx hardhat compile is running the built-in compile task. Tasks can call other tasks, allowing complex workflows to be defined. Users and plugins can override existing tasks, making those workflows customizable and extendable.

> A lot of Hardhat's functionality comes from plugins, and, as a developer, you're free to choose which ones you want to use. Hardhat is unopinionated in terms of what tools you end up using, but it does come with some built-in defaults. All of which can be overriden

## Installation

> Hardhat is used through a local installation in your project. This way your environment will be reproducible, and you will avoid future version conflicts.

> To install it, you need to create an npm project by going to an empty folder, running npm init, and following its instructions. Once your project is ready, you should run

```shell
$npm install hardhat
```

> To use your local installation of Hardhat, you need to use npx to run it (i.e. npx hardhat)

## Getting started

> To create your Hardhat project run npx hardhat in your project folder:

```shell
$npx hardhat
Welcome to Hardhat v2.0.8

? What do you want to do? …
❯ Create a sample project
  Create an advanced sample project
  Create an advanced sample project that uses TypeScript
  Create an empty hardhat.config.js
  Quit
```

### Running task

> To first get a quick sense of what's available and what's going on, run npx hardhat in your project folder:

```shell
$npx hardhat
AVAILABLE TASKS:

 accounts              Prints the list of accounts
  check                 Check whatever you need
  clean                 Clears the cache and deletes all artifacts
  compile               Compiles the entire project, building all artifacts
  console               Opens a hardhat console
  coverage              Generates a code coverage report for tests
  flatten               Flattens and prints contracts and their dependencies
  gas-reporter:merge
  help                  Prints this message
  node                  Starts a JSON-RPC server on top of Hardhat Network
  run                   Runs a user-defined script after compiling the project
  test                  Runs mocha tests
  typechain             Generate Typechain typings for compiled contracts
  verify                Verifies contract on Etherscan
```

### Compiling your contracts

> To compile it, simply run:

```shell
$npx hardhat compile
```

### Testing your contracts

> You can run your tests with npx hardhat test

```shell
$npx hardhat test
```

### Deploying your contracts

> Next, to deploy the contract we will use a Hardhat script. Inside scripts/ you will find sample-script.js with the following code

> Run it with npx hardhat run scripts/sample-script.js:

```shell
$npx hardhat run scripts/sample-script.js
```

```js
// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require('hardhat')

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Greeter = await hre.ethers.getContractFactory('Greeter')
  const greeter = await Greeter.deploy('Hello, Hardhat!')

  await greeter.deployed()

  console.log('Greeter deployed to:', greeter.address)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
```

### Connecting a wallet or Dapp to Hardhat Network

> Hardhat will always spin up an in-memory instance of Hardhat Network on startup by default. It's also possible to run Hardhat Network in a standalone fashion so that external clients can connect to it. This could be MetaMask, your Dapp front-end, or a script.

```shell
$npx hardhat node
Started HTTP and WebSocket JSON-RPC server at http://127.0.0.1:8545/
```

> This will expose a JSON-RPC interface to Hardhat Network. To use it connect your wallet or application to http://localhost:8545. If you want to connect Hardhat to this node to, for example, run a deployment script against it, you simply need to run it using --network localhost.

> To try this, start a node with npx hardhat node and re-run the sample script using the network option:

```shell
$npx hardhat run scripts/sample-script.js --network localhost
```

## Hardhat network

> Hardhat comes built-in with Hardhat Network, a local Ethereum network node designed for development, akin to Ganache, geth --dev, etc. It allows you to deploy your contracts, run your tests and debug your code

> It runs as either an in-process or stand-alone daemon, servicing JSON-RPC and WebSocket requests. By default, it mines a block with each transaction that it receives, in order and with no delay.

> It's backed by the @ethereumjs/vm EVM implementation, the same one used by ganache, Remix and Ethereum Studio.

### How to use

> By default, if you're using Hardhat, then you're already using Hardhat Network. When Hardhat executes your tests, scripts or tasks, an in-process Hardhat Network node is started automatically, and all of Hardhat's plugins (ethers.js, web3.js, Waffle, Truffle, etc) will connect directly to this node's provider.

> There's no need to make any changes to your tests or scripts. Hardhat Network is simply another network. If you wanted to be explicit, you could run, for example, npx hardhat run --network hardhat scripts/my-script.js

### Running stand-alone in order to support wallets and other software

> Alternatively, Hardhat Network can run in a stand-alone fashion so that external clients can connect to it. This could be MetaMask, your Dapp front-end, or a script. To run Hardhat Network in this way, run:

```shell
$npx hardhat node
Started HTTP and WebSocket JSON-RPC server at http://127.0.0.1:8545/

Accounts
========
Account #0: 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266 (10000 ETH)
Private Key: 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

Account #1: 0x70997970c51812dc3a010c7d01b50e0d17dc79c8 (10000 ETH)
Private Key: 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d
...
```

> This will start Hardhat Network, and expose it as a JSON-RPC and WebSocket server. Then, just connect your wallet or application to http://localhost:8545. If you want to connect Hardhat to this node, you just need to run using --network localhost

### Solidity stack traces

> Hardhat Network has first-class Solidity support. It always knows which smart contracts are being run, what they do exactly and why they fail.

> If a transaction or call fails, Hardhat Network will throw an exception. This exception will have a combined JavaScript and Solidity stack trace: stack traces that start in JavaScript/TypeScript up to your call to the contract, and continue with the full Solidity call stack.

```
Error: Transaction reverted: function selector was not recognized and there's no fallback function
  at ERC721Mock.<unrecognized-selector> (contracts/mocks/ERC721Mock.sol:9)
  at ERC721Mock._checkOnERC721Received (contracts/token/ERC721/ERC721.sol:334)
  at ERC721Mock._safeTransferFrom (contracts/token/ERC721/ERC721.sol:196)
  at ERC721Mock.safeTransferFrom (contracts/token/ERC721/ERC721.sol:179)
  at ERC721Mock.safeTransferFrom (contracts/token/ERC721/ERC721.sol:162)

  at TruffleContract.safeTransferFrom (node_modules/@nomiclabs/truffle-contract/lib/execute.js:157:24)
  at Context.<anonymous> (test/token/ERC721/ERC721.behavior.js:321:26)
```

> The last two lines correspond to the JavaScript test code that executed a failing transaction. The rest is the Solidity stack trace. This way you know exactly why your tests aren't passing

## Console.log

> Hardhat Network allows you to print logging messages and contract variables by calling console.log() from your Solidity code.

> To use it, you simply import hardhat/console.sol and call it. It implements the same formatting options that can be found in Node.js' console.log (opens new window), which in turn uses util.format (opens new window). For example: console.log("Changing owner from %s to %s", currentOwner, newOwner).

> It always works, regardless of the call or transaction failing or being successful. And, because it's implemented in standard Solidity, it works with any tool or library, emitting log entries where it's fully supported — Hardhat Network, Remix, and Tenderly — and falling back gracefully to a no-op everywhere else — Remix, Waffle, Truffle, etc — though it does consume a small amount of gas on live networks.

## Mainnet folking

> Hardhat Network has the ability to copy the state of the mainnet blockchain into your local environment, including all balances and deployed contracts. This is known as "forking mainnet."

> In a local environment forked from mainnet, you can execute transactions to invoke mainnet-deployed contracts, or interact with the network in any other way that you would with mainnet. In addition, you can do anything supported by a non-forked Hardhat Network: see console logs, get stack traces, or use the default accounts to deploy new contracts.

> More generally, Hardhat Network can be used to fork any network, not just mainnet. Even further, Hardhat Network can be used to fork any EVM-compatible blockchain, not just Ethereum.

## Configuration

> When Hardhat is run, it searches for the closest hardhat.config.js file starting from the Current Working Directory. This file normally lives in the root of your project. An empty hardhat.config.js is enough for Hardhat to work.

> The entirety of your Hardhat setup (i.e. your config, plugins and custom tasks) is contained in this file.

### Available config options

> To set up your config, you have to export an object from hardhat.config.js.

> This object can have entries like defaultNetwork, networks, solidity, paths and mocha.

```js
module.exports = {
  defaultNetwork: "rinkeby",
  networks: {
    hardhat: {
    },
    rinkeby: {
      url: "https://eth-rinkeby.alchemyapi.io/v2/123abc123abc123abc123abc123abcde",
      accounts: [privateKey1, privateKey2, ...]
    }
  },
  solidity: {
    version: "0.5.15",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  },
  mocha: {
    timeout: 40000
  }
}
```

### Network configuration

> The networks config field is an optional object where network names map to their configuration. There are two kinds of networks in Hardhat: JSON-RPC (opens new window)based networks, and the built-in Hardhat Network.

> You can customize which network is used by default when running Hardhat by setting the config's defaultNetwork field. If you omit this config, its default value is "hardhat".

#### JSON-RPC based network

> These are networks that connect to an external node. Nodes can be running in your computer, like Ganache, or remotely, like Alchemy or Infura. This kind of network is configured with objects with the following fields:

1. url: The url of the node. This argument is required for custom networks.

1. chainId: An optional number, used to validate the network Hardhat connects to. If not present, this validation is omitted.

1. from: The address to use as default sender. If not present the first account of the node is used.

1. gas: Its value should be "auto" or a number. If a number is used, it will be the gas limit used by default in every transaction. If "auto" is used, the gas limit will be automatically estimated. Default value: "auto".

1. gasPrice: Its value should be "auto" or a number. This parameter behaves like gas. Default value: "auto".

1. gasMultiplier: A number used to multiply the results of gas estimation to give it some slack due to the uncertainty of the estimation process. Default value: 1.

1. accounts: This field controls which accounts Hardhat uses. It can use the node's accounts (by setting it to "remote"), a list of local accounts (by setting it to an array of hex-encoded private keys), or use an HD Wallet. Default value: "remote".

1. httpHeaders: You can use this field to set extra HTTP Headers to be used when making JSON-RPC requests. It accepts a JavaScript object which maps header names to their values. Default value: undefined.

1. timeout: Timeout in ms for requests sent to the JSON-RPC server. If the request takes longer than this, it will be cancelled. Default value: 40000 for the localhost network, 20000 for the rest.

#### HD wallet config

> To use an HD Wallet with Hardhat you should set your network's accounts field to an object with the following fields:

1. mnemonic: A required string with the mnemonic phrase of the wallet.
1. path: The HD parent of all the derived keys. Default value: "m/44'/60'/0'/0".
1. initialIndex: The initial index to derive. Default value: 0.
1. count: The number of accounts to derive. Default value: 20.
1. passphrase: The passphrase for the wallet. Default value: empty string.

#### Solidity configuration

> The solidity config is an optional field that can be one of the following:

1. version
1. settings : settings has the same schema as the settings entry in the Input JSON (opens new window)that can be passed to the compiler. Some commonly used settings are: optimzer, evmVersion
1. compilers
1. overrides

```js
solidity: {
    version : "0.8.10",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      },
      evmVersion : 'london' // default value managed by solc
    },
  },
```

##### Multiple Solidity version

> Hardhat supports projects that use different, incompatible versions of solc. For example, if you have a project where some files use Solidity 0.5 and others use 0.6, you can configure Hardhat to use compiler versions compatible with those files like this:

```js
module.exports = {
  solidity: {
    compilers: [
      {
        version: '0.5.5',
      },
      {
        version: '0.6.7',
        settings: {},
      },
    ],
  },
}
```

> This setup means that a file with a pragma solidity ^0.5.0 will be compiled with solc 0.5.5 and a file with a pragma solidity ^0.6.0 will be compiled with solc 0.6.7.

## Typescript support

> Hardhat will automatically enable its TypeScript support if your config file ends in .ts and is written in valid TypeScript. This requires a few changes to work properly.

> Hardhat uses TypeScript and ts-node under the hood, so you need to install them.

> When using JavaScript, all the properties in the HRE are injected into the global scope, and are also available by getting the HRE explicitly. When using TypeScript nothing will be available in the global scope and you will need to import everything explicitly.

## Connecting to Metamask

Check [this youtube tutorial](https://www.youtube.com/watch?v=FTDEX3S1eqU&list=PLFPZ8ai7J-iR-ysy5PeYDgWLu2513aO0i&index=2) to connect Metamask with hardhat node. Basically technique is that run hardhat node first with below command

```shell
$npx hardhat node
```

And then add hardhat local network to Metamask.

- Network name : Hardhat
- RPC URL : http://127.0.0.1:8545/
- Chain ID : 31337

Get dummy accounts from the hardhat node. Copy and paste private key to Metamask.

Through the account, you can send ether back and forth.

## Verify smart contract

Hardhat lets you verify contract in etherscan easily.

1. deploy your contract in the network you want(here ropsten testnet).

```shell
$npx hardhat run scripts/deploy.ts --network ropsten
```

1. verify the contact with etherscan. If the contract has arguments in constructor, provide them.

```shell
# no argument
$npx hardhat verify (the contract address here) --network ropsten

# simple arguments
$npx hardhat verify (the contract address here) --network ropsten "argument 1"

# complet arguments
$npx hardhat verify --constructor-args arguments.js (the contract address here)
```

Once successfully verified, it will log Etherscan link in terminal.

## Creating a task

> This guide will explore the creation of tasks in Hardhat, which are the core component used for automation.

> A task is a JavaScript async function with some associated metadata. This metadata is used by Hardhat to automate some things for you. Arguments parsing, validation, and help messages are taken care of.

> Everything you can do in Hardhat is defined as a task. The default actions that come out of the box are built-in tasks and they are implemented using the same APIs that are available to you as a user.

```
$ npx hardhat
Hardhat version 2.0.0

Usage: hardhat [GLOBAL OPTIONS] <TASK> [TASK OPTIONS]

GLOBAL OPTIONS:

  --config              A Hardhat config file.
  --emoji               Use emoji in messages.
  --help                Shows this message, or a task's help if its name is provided
  --max-memory          The maximum amount of memory that Hardhat can use.
  --network             The network to connect to.
  --show-stack-traces   Show stack traces.
  --tsconfig            A TypeScript config file.
  --verbose             Enables Hardhat verbose logging
  --version             Shows hardhat's version.


AVAILABLE TASKS:

  check         Check whatever you need
  clean         Clears the cache and deletes all artifacts
  compile       Compiles the entire project, building all artifacts
  console       Opens a hardhat console
  flatten       Flattens and prints contracts and their dependencies
  help          Prints this message
  node          Starts a JSON-RPC server on top of Hardhat Network
  run           Runs a user-defined script after compiling the project
  test          Runs mocha tests

To get help for a specific task run: npx hardhat help [task]
```

> Let’s go through the process of creating one to interact with a smart contract.

> Tasks in Hardhat are asynchronous JavaScript functions that get access to the Hardhat Runtime Environment, which exposes its configuration and parameters, as well as programmatic access to other tasks and any plugin objects that may have been injected.

> For our example, we will use Web3.js to interact with our contracts, so we will install the Web3.js plugin, which injects a Web3.js instance into the Hardhat environment:

```sh
npm install --save-dev @nomiclabs/hardhat-web3 web3
```

> Task creation code can go in hardhat.config.js, or whatever your configuration file is called. It’s a good place to create simple tasks. If your task is more complex, it's also perfectly valid to split the code into several files and require them from the configuration file.

> For this tutorial, we're going to create a task to get an account’s balance from the terminal. You can do this with the Hardhat’s config DSL, which is available in the global scope of hardhat.config.js:

```js
require('@nomiclabs/hardhat-web3')

task('balance', "Prints an account's balance").setAction(async () => {})

module.exports = {}
```

> Now let’s implement the functionality we want. We need to get the account address from the user. We can do this by adding a parameter to our task:

```js
require('@nomiclabs/hardhat-web3')

task('balance', "Prints an account's balance")
  .addParam('account', "The account's address")
  .setAction(async () => {})

module.exports = {}
```

> When you add a parameter to a task, Hardhat will handle its help messages for you.

> task's first argument is the task name. The second one is its description, which is used for printing help messages in the CLI. The third one is an async function that receives the following arguments:

> Let’s now get the account’s balance. The Hardhat Runtime Environment will be available in the global scope. By using Hardhat’s Web3.js plugin we get access to a Web3.js instance:

```js
require('@nomiclabs/hardhat-web3')

task('balance', "Prints an account's balance")
  .addParam('account', "The account's address")
  .setAction(async (taskArgs) => {
    const account = web3.utils.toChecksumAddress(taskArgs.account)
    const balance = await web3.eth.getBalance(account)

    console.log(web3.utils.fromWei(balance, 'ether'), 'ETH')
  })

module.exports = {}
```

> Finally, we can run it:

```sh
npx hardhat balance --account 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
10000 ETH
```

## Hardhat Runtime Environment (HRE)

> The Hardhat Runtime Environment, or HRE for short, is an object containing all the functionality that Hardhat exposes when running a task, test or script. In reality, Hardhat is the HRE.

> When you require Hardhat (const hardhat = require("hardhat")) you're getting an instance of the HRE.

> During initialization, the Hardhat configuration file essentially constructs a list of things to be added to the HRE. This includes tasks, configs and plugins. Then when tasks, tests or scripts run, the HRE is always present and available to access anything that is contained in it.

> The HRE has a role of centralizing coordination across all Hardhat components. This architecture allows for plugins to inject functionality that becomes available everywhere the HRE is accessible.

### Using the HRE

> Before running a task, test or script, Hardhat injects the HRE into the global scope, turning all of its fields into global variables. When the task execution is completed, these global variables are removed, restoring their original value, if they had one.

> Not everyone likes magic global variables, and Hardhat doesn't force you to use them. Everything can be done explicitly in tasks, tests and scripts.

> When writing tests or scripts, you can use require("hardhat") to import the HRE. You can read more about this in Accessing the HRE from outside a task.

> You can import the config DSL explicitly when defining your tasks, and receive the HRE explicitly as an argument to your actions. You can read more about this in Creating your own tasks.

## Reference

- https://hardhat.org/
- [Hardhat Tutorials | NFT OpenZeppelin ERC721](https://www.youtube.com/playlist?list=PLw-9a9yL-pt3sEhicr6gmuOQdcmWXhCx4)
