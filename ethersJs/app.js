import { BigNumber, ethers } from 'ethers'
import * as dotenv from 'dotenv'

dotenv.config()

console.log(ethers.providers.getNetwork('kovan'))
// default provider is recommended for prodution use
const projectId = process.env.INFURA_PROJECT_ID
const projectSecret = process.env.INFURA_PROJECT_SECRET
const ropstenProvider = new ethers.providers.getDefaultProvider('ropsten', {
    projectId,
    projectSecret,
})
console.log(ropstenProvider)

// signer: ethereum account
// signer class is abstract. should use 1) VoidSigner 2) Wallet 3) JsonRpcSigner
const voidSigner = new ethers.VoidSigner(
    process.env.METAMASK_ROPSTEN_ACCOUNT,
    ropstenProvider
)
console.log('void signer', voidSigner.address)
const walletSigner = new ethers.Wallet(
    process.env.METAMASK_ROPSTEN_PRIVATE_KEY,
    ropstenProvider
)

console.log('jsonrpc', jsonRpcSigner._address)

console.log(walletSigner)
console.log(await walletSigner.getBalance())

// convert balance in hex to balance in big int(documented in wei)
console.log(BigNumber.from(await walletSigner.getBalance()).toBigInt())
console.log('5000000000000000000'.length) // in wei
console.log(walletSigner.publicKey)
console.log(BigNumber.from(await walletSigner.getGasPrice()).toBigInt()) // multiply 1/100
console.log(
    walletSigner.connect(ropstenProvider).address === walletSigner.address
)
