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
```

## Reference 
- https://hardhat.org/
- [Hardhat Tutorials | NFT OpenZeppelin ERC721](https://www.youtube.com/playlist?list=PLw-9a9yL-pt3sEhicr6gmuOQdcmWXhCx4)

