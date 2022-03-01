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
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const Greeter = await hre.ethers.getContractFactory("Greeter");
  const greeter = await Greeter.deploy("Hello, Hardhat!");

  await greeter.deployed();

  console.log("Greeter deployed to:", greeter.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
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



## Reference 
- https://hardhat.org/
- [Hardhat Tutorials | NFT OpenZeppelin ERC721](https://www.youtube.com/playlist?list=PLw-9a9yL-pt3sEhicr6gmuOQdcmWXhCx4)

