import 'ethers'
import { BigNumber, Contract, ethers, Wallet } from 'ethers'
import * as dotenv from 'dotenv'

dotenv.config()

const projectId = process.env.INFURA_PROJECT_ID
const projectSecret = process.env.INFURA_PROJECT_SECRET

// default provider is recommended to use. connected to as many as backend services
const defaultProvider = new ethers.getDefaultProvider('ropsten', {
    projectId,
    projectSecret,
})

// individual provider
const provider = new ethers.providers.InfuraProvider('ropsten')

// getGasPrice is a legacy
console.log(BigNumber.from(await provider.getGasPrice()).toBigInt())

console.log(await provider.getFeeData())
// console.log(ethers.utils.formatUnits(await provider.getFeeData(), 'ether'))
