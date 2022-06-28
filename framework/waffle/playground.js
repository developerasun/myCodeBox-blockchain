const { expect } = require('chai')
const { describe, it } = require('mocha')
const { ethers } = require('hardhat')
require('hardhat-waffle')
require('@nomiclabs/hardhat-ethers')

const { MockProvider, deployContract, deployMockContract, link, solidity, loadFixture, createFixtureLoader } = require('ethereum-waffle')
const MockBasicToken = require('../../projects/build/AliceToken.json')
const ganacheOptions = {}

chai.use(solidity) // connect solidity to chai

// create a provider instance: ganache behined the scene
const provider = new MockProvider()

// create a wallet
const [wallet, anotherWallet] = provider.getWallets()
console.log(wallet, anotherWallet)

// deploy a contract: use abi that is created after waffle compilation
const token = await deployContract(wallet, MockBasicToken, [wallet.address])

console.log(ethers.utils.toUtf8Bytes('street'))

const hashedStreet = ethers.utils.keccak256(ethers.utils.toUtf8Bytes('street'))
console.log(hashedStreet)

// test if a function is called
expect('balanceOf').to.be.calledOnContract(token)

// test if an event is called
expect(MockBasicToken.transfer(wallet.address, 7)).to.emit(MockBasicToken, 'Transfer').withArgs(wallet.address, anotherWallet.address, 7)

describe('Fixtures', function () {
    // fixture is a function
    async function fixture([wallet, other], provider) {
        const token = await deployContract(wallet, MockBasicToken, [wallet.address, 1000])
        return { token, wallet, other } // deliver to loadFixture
    }

    it('assigns initial balance', async () => {
        const { token, wallet } = await loadFixture(fixture)
        expect(await token.balanceOf(wallet.address)).to.equal(1000)
    })

    it('transfer adds amount to destination account', async () => {
        const { token, other } = await loadFixture(fixture)
        await token.transfer(other.address, 7)
        expect(await token.balanceOf(other.address)).to.eq(7)
    })
})

describe('use custom fixtureLoader', async function customFixture([wallet, other], provider) {
    const myWallet = new MockProvider().getWallets()
    const myProvider = new MockProvider().provider
    const loadFixture = createFixtureLoader(myWallet, myProvider)

    await loadFixture((myWallet, myProvider) => {})
})

const mockContract = await deployMockContract(wallet, MockBasicToken.abi)
mockContract.mock.someMethod().returns(5)
