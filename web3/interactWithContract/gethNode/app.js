import Web3 from 'web3'
import { createRequire } from 'module'

const require = createRequire(import.meta.url)

// Truffle framework: inserts a deployed network info to metadata json file
// Hardhat, Remix: does not insert

const ganacheProvider = 'HTTP://127.0.0.1:7545' // network id: 5777
const gethProvider = 'HTTP://127.0.0.1:8545' // network id: 1337

const web3 = new Web3(gethProvider)
const ganacheWeb3 = new Web3(ganacheProvider)

const id = await web3.eth.net.getId()
const json = require('./Jake.json')
console.log('network id is : ', id)

const wrongAddr = '0xAd6b120261f47ADd35cDbc18CEF83978602FC8D1' // Remix Javascript VM address
const gethAddr = '0x0C6589c0A4141872aDd80E1ebE91aAe1a4A9418f' // Geth web3 provider
const javascriptVMaddr = '0xd9145CCE52D386f254917e481eB44e9943F39138' // won't work. will throw: returned values aren't valid error

const contract = new web3.eth.Contract(json.abi, gethAddr)
const test = new ganacheWeb3.eth.Contract(json.abi, javascriptVMaddr)

// working
contract.methods
    .getName()
    .call()
    .then((res) => console.log(res))
    .catch((err) => console.log(err))

// not working
test.methods
    .getName()
    .call()
    .then((res) => console.log(res))
    .catch((err) => console.log(err))
