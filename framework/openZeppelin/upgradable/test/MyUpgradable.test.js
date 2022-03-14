const { ethers, upgrades } = require('hardhat')

describe('MyUpgradableERC20', function() {
    it('deploys', async function() {
        const v1 = await ethers.getContractFactory('MyUpgradable.sol')
        await v1.deploy()

        // deploy the proxy with UUPS pattern
        await upgrades.deployProxy(v1, {kind: 'uups'})

        // get proxy address
        const address = await upgrades.deployProxy(v1, {kind: 'uups'})
        console.log(address.address)
        // get a new contract version
        // const v2 = await ethers.getContractFactory('MyUpgradableV2.sol')

        // // upgrade proxy with the new contract
        // await upgrades.upgradeProxy(address, v2)
    })
})