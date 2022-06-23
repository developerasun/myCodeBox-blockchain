import 'ethers'
import { Contract, ethers, Wallet } from 'ethers'
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

// Ethers.Signer is abstract. Should be implemented Wallet or Void Signer or JsonRPCprovider
const walletSigner = new ethers.Wallet(
    process.env.METAMASK_ROPSTEN_PRIVATE_KEY,
    defaultProvider
)

const myAddr = await walletSigner.getAddress()

const myContract = new Contract(
    process.env.CONTRACT_ADDRESS,
    process.env.CONTRACT_ABI
)

console.log(myAddr)

const contractAddrFromEtherscan = process.env.CONTRACT_ADDRESS
const oneAccountFromEtherscan = '0xf5de760f2e916647fd766b4ad9e85ff943ce3a2b'

// contract.filters.EVENT_NAME
const event = myContract.filters.Transfer()

// set event query filter
const filter = {
    fromBlock: -10,
    toBlock: 'latest',
    topics: event.topics,
}

// provider.getLogs(event filter) => fetch tx histories from the provider network
console.log(await provider.getLogs(filter))

// console.log(filterFrom)
// await myContract.queryFilter(filterFrom, '7', '14')
// // Get the address of the Signer
// myAddress = await signer.getAddress()
// // '0x8ba1f109551bD432803012645Ac136ddd64DBA72'

// // Filter for all token transfers from me
// filterFrom = daiContract.filters.Transfer(myAddress, null)
// // {
// //   address: 'dai.tokens.ethers.eth',
// //   topics: [
// //     '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
// //     '0x0000000000000000000000008ba1f109551bd432803012645ac136ddd64dba72'
// //   ]
// // }

// // Filter for all token transfers to me
// filterTo = daiContract.filters.Transfer(null, myAddress)
// // {
// //   address: 'dai.tokens.ethers.eth',
// //   topics: [
// //     '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
// //     null,
// //     '0x0000000000000000000000008ba1f109551bd432803012645ac136ddd64dba72'
// //   ]
// // }

// // List all transfers sent from me in a specific block range
// await daiContract.queryFilter(filterFrom, 9843470, 9843480)
// // [
// //   {
// //     address: '0x6B175474E89094C44Da98b954EedeAC495271d0F',
// //     args: [
// //       '0x8ba1f109551bD432803012645Ac136ddd64DBA72',
// //       '0x8B3765eDA5207fB21690874B722ae276B96260E0',
// //       { BigNumber: "4750000000000000000" },
// //       amount: { BigNumber: "4750000000000000000" },
// //       from: '0x8ba1f109551bD432803012645Ac136ddd64DBA72',
// //       to: '0x8B3765eDA5207fB21690874B722ae276B96260E0'
// //     ],
// //     blockHash: '0x8462eb2fbcef5aa4861266f59ad5f47b9aa6525d767d713920fdbdfb6b0c0b78',
// //     blockNumber: 9843476,
// //     data: '0x00000000000000000000000000000000000000000000000041eb63d55b1b0000',
// //     decode: [Function],
// //     event: 'Transfer',
// //     eventSignature: 'Transfer(address,address,uint256)',
// //     getBlock: [Function],
// //     getTransaction: [Function],
// //     getTransactionReceipt: [Function],
// //     logIndex: 69,
// //     removeListener: [Function],
// //     removed: false,
// //     topics: [
// //       '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
// //       '0x0000000000000000000000008ba1f109551bd432803012645ac136ddd64dba72',
// //       '0x0000000000000000000000008b3765eda5207fb21690874b722ae276b96260e0'
// //     ],
// //     transactionHash: '0x1be23554545030e1ce47391a41098a46ff426382ed740db62d63d7676ff6fcf1',
// //     transactionIndex: 81
// //   },
// //   {
// //     address: '0x6B175474E89094C44Da98b954EedeAC495271d0F',
// //     args: [
// //       '0x8ba1f109551bD432803012645Ac136ddd64DBA72',
// //       '0x00De4B13153673BCAE2616b67bf822500d325Fc3',
// //       { BigNumber: "250000000000000000" },
// //       amount: { BigNumber: "250000000000000000" },
// //       from: '0x8ba1f109551bD432803012645Ac136ddd64DBA72',
// //       to: '0x00De4B13153673BCAE2616b67bf822500d325Fc3'
// //     ],
// //     blockHash: '0x8462eb2fbcef5aa4861266f59ad5f47b9aa6525d767d713920fdbdfb6b0c0b78',
// //     blockNumber: 9843476,
// //     data: '0x00000000000000000000000000000000000000000000000003782dace9d90000',
// //     decode: [Function],
// //     event: 'Transfer',
// //     eventSignature: 'Transfer(address,address,uint256)',
// //     getBlock: [Function],
// //     getTransaction: [Function],
// //     getTransactionReceipt: [Function],
// //     logIndex: 70,
// //     removeListener: [Function],
// //     removed: false,
// //     topics: [
// //       '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
// //       '0x0000000000000000000000008ba1f109551bd432803012645ac136ddd64dba72',
// //       '0x00000000000000000000000000de4b13153673bcae2616b67bf822500d325fc3'
// //     ],
// //     transactionHash: '0x1be23554545030e1ce47391a41098a46ff426382ed740db62d63d7676ff6fcf1',
// //     transactionIndex: 81
// //   }
// // ]

// //
// // The following have had the results omitted due to the
// // number of entries; but they provide some useful examples
// //

// // List all transfers sent in the last 10,000 blocks
// await daiContract.queryFilter(filterFrom, -10000)

// // List all transfers ever sent to me
// await daiContract.queryFilter(filterTo)
