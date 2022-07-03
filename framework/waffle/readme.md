# Learning waffle essentials

> Waffle is a library for writing and testing smart contracts. Sweeter, simpler and faster than Truffle. Works with ethers-js.

## Features

1. Sweet set of chai matchers,
1. Easy contract importing from npm modules,
1. Fast compilation with native and dockerized solc,
1. Typescript compatible,
1. Fixtures that help write fast and maintainable test suites,
1. Well documented.

## Versions and ethers compatibility

- Use version 0.2.3 with ethers 3 and solidity 4,

- Use version 1.2.0 with ethers 4 and solidity 4,

- Use version 2._._ with ethers 4, solidity 4, 5 and ability to use native or dockerized solc.

- Use version 3._._ with ethers 5, solidity 4, 5, 6 and ability to use native, dockerized solc or dockerized vyper.

## Getting started

> To get started, install ethereum-waffle:

```sh
npm install --save-dev ethereum-waffle
```

> Since Waffle 3.0.0 it recognises waffle.json as default configuration file. If your configuration file is called waffle.json, it’s possible to use just waffle to build contracts.

```json
{
  "compilerType": "solcjs",
  "compilerVersion": "0.8.13",
  "sourceDirectory": "./src",
  "outputDirectory": "./build"
}
```

> If you want to know more about how to configure Waffle, see Configuration.

## Writing tests

> After you have successfully authored a Smart Contract you can now think about testing it. Fortunately for you, Waffle is packed with tools that help with that.

> Tests in waffle are written using Mocha alongside with Chai. You can use a different test environment, but Waffle matchers only work with chai.

> If you are using Typescript don’t forget to add ts-node, typescript and @types/mocha to your devDependencies. Also, make sure to add a tsconfig.json, and within it, set "esModuleInterop" and "resolveJsonModule" to true.

## Basic testing

### Creating a provider

> Creating a mock provider for your tests is super simple.

```js
import { MockProvider } from 'ethereum-waffle'
const provider = new MockProvider()
```

> This class takes an optional MockProviderOptions parameter in the constructor. Then the ganacheOptions from MockProviderOptions are passed to the underlying ganache-core implementation. You can read more about the options here.

### Getting wallets

> To obtain wallets that have been prefunded with eth use the provider

```js
import { MockProvider } from 'ethereum-waffle'

const provider = new MockProvider()
const [wallet, otherWallet] = provider.getWallets()

// or use a shorthand

const [wallet, otherWallet] = new MockProvider().getWallets()
```

> By default this method returns 10 wallets. You can modify the returned wallets, by changing MockProvider configuration.

### Deploying contracts

> Once you compile your contracts using waffle, you can deploy them in your javascript code. It accepts three arguments:

1. wallet to send the deploy transaction
1. contract information (abi and bytecode)
1. contract constructor arguments

> Deploy a contract

```js
import BasicTokenMock from '../build/BasicTokenMock.json'
const token = await deployContract(wallet, BasicTokenMock, [wallet.address, 1000])
```

### Linking

> Link a library

```js
myLibrary = await deployContract(wallet, MyLibrary, [])
link(LibraryConsumer, 'contracts/MyLibrary.sol:MyLibrary', myLibrary.address)
libraryConsumer = await deployContract(wallet, LibraryConsumer, [])
```

## Chai matcher

> A set of sweet chai matchers, makes your test easy to write and read. Before you can start using the matchers, you have to tell chai to use the solidity plugin:

```js
import chai from "chai
import { solidity } from "ethereum-waffle"
chai.use(solidity)
```

### Bignumbers

> Testing equality of big numbers:

```js
expect(await token.balanceOf(wallet.address)).to.equal(993)
```

> Available matchers for BigNumbers are: equal, eq, above, gt, gte, below, lt, lte, least, most, within, closeTo.

```js
expect(BigNumber.from(100)).to.be.within(BigNumber.from(99), BigNumber.from(101))
expect(BigNumber.from(100)).to.be.closeTo(BigNumber.from(101), 10)
```

### Emitting events

> Testing what events were emitted with what arguments. You must await the expect in order for the matcher to execute properly. Failing to await will cause the assertion to pass whether or not the event is actually emitted!

```js
await expect(token.transfer(walletTo.address, 7)).to.emit(token, 'Transfer').withArgs(wallet.address, walletTo.address, 7)
```

> The matcher will match indexed event parameters of type string or bytes even if the expected argument is not hashed using keccack256 first.

> Testing with indexed bytes or string parameters. These two examples are equivalent.

```js
// implementation 1
await expect(contract.addAddress('street', 'city')).to.emit(contract, 'AddAddress').withArgs('street', 'city')

// implementation 2
const hashedStreet = ethers.utils.keccak256(ethers.utils.toUtf8Bytes('street'))
const hashedCity = ethers.utils.keccak256(ethers.utils.toUtf8Bytes('city'))
await expect(contract.addAddress(street, city)).to.emit(contract, 'AddAddress').withArgs(hashedStreet, hashedCity)
```

### Called on contract

> Testing if function was called on the provided contract:

```js
await token.balanceOf(wallet.address)
expect('balanceOf').to.be.calledOnContract(token)
```

### Called on contract with arguments

> Testing if function with certain arguments was called on provided contract:

```js
await token.balanceOf(wallet.address)
expect('balanceOf').to.be.calledOnContractWith(token, [wallet.address])
```

### Revert

> Testing if transaction was reverted:

```js
await expect(token.transfer(walletTo.address, 1007)).to.be.reverted
```

### Revert with message

> Testing if transaction was reverted with certain message:

```js
await expect(token.transfer(walletTo.address, 1007)).to.be.revertedWith('not enough funds')
```

> You can also test if revert message matches to a regular expression:

```js
await expect(token.transfer(walletTo.address), 1007).to.be.revertedWith(/AccessControl:account .* is missing role .*/)
```

### Change ether balance

> Testing whether the transaction changes the balance of the account:

```js
await expect(await wallet.sendTransaction({ to: walletTo.address, value: 200 })).to.changeEtherBalance(walletTo, 200)
```

> expect for changeEtherBalance gets one of the following parameters:

1. transaction call : () => Promise<TransactionResponse>
1. transaction response : TransactionResponse

> changeEtherBalance won’t work if there is more than one transaction mined in the block.

> The transaction call should be passed to the expect as a callback (we need to check the balance before the call) or as a transaction response.

> The matcher can accept numbers, strings and BigNumbers as a balance change, while the account should be specified either as a Wallet or a Contract.

> changeEtherBalance ignores transaction fees by default:

> changeEtherBalance calls should not be chained. If you need to check changes of the balance for multiple accounts, you should use the changeEtherBalances matcher.

### Change ether balance (multiple accounts)

> Testing whether the transaction changes balance of multiple accounts:

```js
await expect(() => wallet.sendTransaction({ to: walletTo.address, value: 200 })).to.changeEtherBalances([wallet, walletTo], [-200, 200])

await expect(await wallet.sendTransaction({ to: walletTo.address, value: 200 })).to.changeEtherBalances([wallet, walletTo], [-200, 200])
```

> changeEtherBalances calls won’t work if there is more than one transaction mined in the block.

### Change token balance

> Testing whether the transfer changes the balance of the account:

```js
await expect(() => token.transfer(walletTo.address, 200)).to.changeTokenBalance(token, walletTo, 200)

await expect(() => token.transferFrom(wallet.address, walletTo.address, 200)).to.changeTokenBalance(token, walletTo, 200)
```

### Proper address

> Testing if a string is a proper address:

```js
expect('0x28FAA621c3348823D6c6548981a19716bcDc740e').to.be.properAddress
```

### Proper private key

> Testing if a string is a proper private key:

```js
expect('0x706618637b8ca922f6290ce1ecd4c31247e9ab75cf0530a0ac95c0332173d7c5').to.be.properPrivateKey
```

### Proper hex

> Testing if a string is a proper hex value of given length:

```js
expect('0x70').to.be.properHex(2)
```

### Hex Equal

> Testing if a string is a proper hex with value equal to the given hex value. Case insensitive and strips leading zeros:

```js
expect('0x00012AB').to.hexEqual('0x12ab')
```

## Fixture

> When testing code dependent on smart contracts, it is often useful to have a specific scenario play out before every test. For example, when testing an ERC20 token, one might want to check whether each and every address can or cannot perform transfers. Before each of those tests however, you have to deploy the ERC20 contract and maybe transfer some funds.

> The repeated deployment of contracts might slow down the test significantly. This is why Waffle allows you to create fixtures - testing scenarios that are executed once and then remembered by making snapshots of the blockchain. This speeds up the tests considerably.

```js
import { expect } from 'chai'
import { loadFixture, deployContract } from 'ethereum-waffle'
import BasicTokenMock from './build/BasicTokenMock'

describe('Fixtures', () => {
  async function fixture([wallet, other], provider) {
    const token = await deployContract(wallet, BasicTokenMock, [wallet.address, 1000])
    return { token, wallet, other }
  }

  it('Assigns initial balance', async () => {
    const { token, wallet } = await loadFixture(fixture)
    expect(await token.balanceOf(wallet.address)).to.equal(1000)
  })

  it('Transfer adds amount to destination account', async () => {
    const { token, other } = await loadFixture(fixture)
    await token.transfer(other.address, 7)
    expect(await token.balanceOf(other.address)).to.equal(7)
  })
})
```

## Mock contract

> Mocking your smart contract dependencies.

### Usage

> Create an instance of a mock contract providing the ABI of the smart contract you want to mock:

```js
import { deployMockContract } from '@ethereum-waffle/mock-contract'
const mockContract = await deployMockContract(wallet, contractAbi)
```

> The mock contract can now be integrated into other contracts by using the address attribute. Return values for mocked functions can be set using:

```js
await mockContract.mock.<nameOfMethod>.returns(<value>)
await mockContract.mock.<nameOfMethod>.withArgs(<arguments>).returns(<value>)
```

> Methods can also be set up to be reverted using:

```js
await mockContract.mock.<nameOfMethod>.reverts()
await mockContract.mock.<nameOfMethod>.revertsWithReason(<reason>)
await mockContract.mock.<nameOfMethod>.withArgs(<arguments>).reverts()
await mockContract.mock.<nameOfMethod>.withArgs(<arguments>).revertsWithReason(<reason>)
```

### Example

> The example below illustrates how mock-contract can be used to test the very simple AmIRichAlready contract.

```solidity
pragma solidity ^0.6.0;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
}

contract AmIRichAlready {
    IERC20 private tokenContract;
    uint private constant RICHNESS = 1000000 * 10 ** 18;

    constructor (IERC20 _tokenContract) public {
        tokenContract = _tokenContract;
    }

    function check() public view returns (bool) {
        uint balance = tokenContract.balanceOf(msg.sender);
        return balance > RICHNESS;
    }
}
```

> We are mostly interested in the tokenContract.balanceOf call. Mock contract will be used to mock exactly this call with values that are relevant for the return of the check() method.

```js
const { use, expect } = require('chai')
const { ContractFactory, utils } = require('ethers')
const { MockProvider } = require('@ethereum-waffle/provider')
const { waffleChai } = require('@ethereum-waffle/chai')
const { deployMockContract } = require('@ethereum-waffle/mock-contract')

const IERC20 = require('../build/IERC20')
const AmIRichAlready = require('../build/AmIRichAlready')

use(waffleChai)

describe('Am I Rich Already', () => {
  async function setup() {
    const [sender, receiver] = new MockProvider().getWallets()
    const mockERC20 = await deployMockContract(sender, IERC20.abi)
    const contractFactory = new ContractFactory(AmIRichAlready.abi, AmIRichAlready.bytecode, sender)
    const contract = await contractFactory.deploy(mockERC20.address)
    return { sender, receiver, contract, mockERC20 }
  }

  it('returns false if the wallet has less then 1000000 coins', async () => {
    const { contract, mockERC20 } = await setup()
    await mockERC20.mock.balanceOf.returns(utils.parseEther('999999'))
    expect(await contract.check()).to.be.equal(false)
  })

  it('returns true if the wallet has more than 1000000 coins', async () => {
    const { contract, mockERC20 } = await setup()
    await mockERC20.mock.balanceOf.returns(utils.parseEther('1000001'))
    expect(await contract.check()).to.equal(true)
  })

  it('reverts if the ERC20 reverts', async () => {
    const { contract, mockERC20 } = await setup()
    await mockERC20.mock.balanceOf.reverts()
    await expect(contract.check()).to.be.revertedWith('Mock revert')
  })

  it('returns 1000001 coins for my address and 0 otherwise', async () => {
    const { contract, mockERC20, sender, receiver } = await setup()
    await mockERC20.mock.balanceOf.returns('0')
    await mockERC20.mock.balanceOf.withArgs(sender.address).returns(utils.parseEther('1000001'))

    expect(await contract.check()).to.equal(true)
    expect(await contract.connect(receiver.address).check()).to.equal(false)
  })
})
```

## Configuration

> While Waffle works well enough without any configurations, advanced users might want to excert more control over what happens when they use Waffle in their projects. This is why we made it very easy to configure Waffle to meet your needs. All you need to do is create a waffle.json file inside your project and point waffle to it.

> First create your waffle.json configuration file:

```json
{
  "compilerType": "solcjs",
  "compilerVersion": "0.6.2",
  "sourceDirectory": "./contracts",
  "outputDirectory": "./build"
}
```

> Since Waffle 3.0.0 it recognises waffle.json as the default configuration file. If your configuration file is called waffle.json, it’s possible to use just waffle to build contracts.

```json
{
  "scripts": {
    "build": "waffle"
  }
}
```

### SourceDirectory

> You can specify a custom path to the directory containing your smart contracts. Waffle uses ./contracts as the default value for sourceDirectory. The path you provide will be resolved relative to the current working directory.

```json
{
  "sourceDirectory": "./custom/path/to/contracts"
}
```

### OutputDirectory

> You can specify a custom path to the directory to which Waffle saves the compilation output. Waffle uses ./build as the default value for outputDirectory. The path you provide will be resolved relative to the current working directory.

```json
{
  "outputDirectory": "./custom/path/to/output"
}
```

### NodeModulesDirectory

> You can specify a custom path to the node_modules folder which Waffle will use to resolve third party dependencies. Waffle uses ./node_modules as the default value for nodeModulesDirectory. The path you provide will be resolved relative to the current working directory.

```json
{
  "nodeModulesDirectory": "./custom/path/to/node_modules"
}
```

### CacheDirectory

> When compiling using solcjs and using a non-default compilerVersion Waffle downloads the necessary solcjs binary from a remote server. This file is cached to speed up subsequent runs. You can specify a custom path to the directory in which caches are saved. Waffle uses ./cache as the default value for cacheDirectory. The path you provide will be resolved relative to the current working directory.

```json
{
  "cacheDirectory": "./custom/path/to/cache"
}
```

### CompilerVersion

> Specifies the version of the compiler. Should be a semver string like 0.5.9. You can use it with "compilerType": "solcjs" or "compilerType": "dockerized-solc".

> When using "compilerType": "solcjs" you can also specify the exact commit that will be used or a path to a specific solc module dependency.

```json
{
  "compilerType": "solcjs",
  "compilerVersion": "./node_modules/solc"
}
```

### CompilerAllowedPaths

> The solc compiler has restrictions on paths it can access for security reasons. The value of compilerAllowedPaths will be passed as a command line argument: solc --allow-paths <VALUE>.

This is especially useful if you are doing a monorepo setup with Lerna, see: Usage with Lernajs.

```json
{
  "compilerAllowedPaths": ["../contracts"]
}
```

### CompilerOptions

> You can customize the behaviour of solc by providing custom settings for it. All of the information is provided in the Solidity documentation. Value of the compilerOptions configuration setting will be passed to solc as settings.

> For detailed list of options go to solidity documentation (sections: ‘Setting the EVM version to target’, ‘Target options’ and ‘Compiler Input and Output JSON Description’).

```json
{
  "compilerOptions": {
    "evmVersion": "constantinople"
  }
}
```

### OutputHumanReadableAbi

> Waffle supports Human Readable Abi. In order to enable its output, you need to set outputHumanReadableAbi to true in your config file:

```json
{
  "outputHumanReadableAbi": true
}
```

> For the compiled contracts you will now see the following in the output:

```json
{
  "humanReadableAbi": [
    "constructor(uint256 argOne)",
    "event Bar(bool argOne, uint256 indexed argTwo)",
    "event FooEvent()",
    "function noArgs() view returns(uint200)",
    "function oneArg(bool argOne)",
    "function threeArgs(string argOne, bool argTwo, uint256[] argThree) view returns(bool, uint256)",
    "function twoReturns(bool argOne) view returns(bool, uint256)"
  ]
}
```

### Typechain

> Waffle supports typechain artifacts generation. To enable typed artifacts generation you should set typechainEnabled property to true. You are also able to define target folder for your artifacts by defining typechainOutputDir property, which is set to ./types by default. Property typechainOutputDir is a path relative to outputDirectory.

```json
{
  "typechainEnabled": true,
  "typechainOutputDir": "typechain"
}
```

### Other configuration file formats

> Waffle supports the following configuration file formats: JSON, Javascript, Promise

> This is a powerful feature if you want to asynchronously load different compliation configurations in different environments. For example, you can use native solc in CI for faster compilation, while deciding the exact solc-js version locally based on the contract versions being used. Since many of those operations are asynchronous, you’ll most likely be returning a Promise to waffle to handle.

```json
{
  "sourceDirectory": "./src/contracts"
}
```

```js
module.exports = {
  sourceDirectory: './src/contracts',
}
```

```js
module.exports = Promise.resolve({
  sourceDirectory: './src/contracts',
})
```

### Monorepo

> Waffle works well with mono-repositories. It is enough to set up a common nodeModulesDirectory in the configuration file to make it work. We recommend using yarn workspaces, wsrun, and Lerna.js for monorepo management.

## Reference

- [Ethereum-Waffle](https://ethereum-waffle.readthedocs.io/en/latest/)
