import { expect, use, assert } from 'chai'
import { Contract } from 'ethers'
import { deployContract, MockProvider, solidity } from 'ethereum-waffle'
import AliceToken from '../build/AliceToken.json'

use(solidity)

// contract test unit: in wei
describe('AliceToken', () => {
    const [wallet, walletTo] = new MockProvider().getWallets()
    let token: Contract

    beforeEach(async () => {
        token = await deployContract(wallet, AliceToken)
    })

    it('Assigns initial balance', async () => {
        expect(await token.balanceOf(wallet.address)).to.equal('100000000000000000000')
    })

    it('Transfer adds amount to destination account', async () => {
        await token.transfer(walletTo.address, 7)
        assert.strictEqual(await token.balanceOf(walletTo.address), 7)
        // expect(await token.balanceOf(walletTo.address)).to.equal(7);
    })

    it('Transfer emits event', async () => {
        await expect(token.transfer(walletTo.address, 7)).to.emit(token, 'Transfer').withArgs(wallet.address, walletTo.address, 7)
    })

    it('Can not transfer above the amount', async () => {
        await expect(token.transfer(walletTo.address, '100000000000000000004')).to.be.reverted
    })

    it('Can not transfer from empty account', async () => {
        const tokenFromOtherWallet = token.connect(walletTo)
        await expect(tokenFromOtherWallet.transfer(wallet.address, 1)).to.be.reverted
    })

    it('Calls totalSupply on AliceToken contract', async () => {
        await token.totalSupply()
        expect('totalSupply').to.be.calledOnContract(token)
    })

    it('Calls balanceOf with sender address on AliceToken contract', async () => {
        await token.balanceOf(wallet.address)
        expect('balanceOf').to.be.calledOnContractWith(token, [wallet.address])
    })
})
