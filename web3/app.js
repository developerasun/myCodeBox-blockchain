import web3 from 'web3'

// don't forget to add file extension when using ES6 named import
import { web3Key } from './config/key.js'

const infuraAPI = web3Key.INFURA
const myWeb3 = new web3(infuraAPI)

// console.log(myWeb3)
const address = '0x3775c39bb828b1d212c483e01b129612c173afe1' // copy a random(but real)address from etherscan
myWeb3.eth.getBalance(address, async (err, wei) => {
    const checkBalance = myWeb3.utils.fromWei(wei, 'ether') // convert wei to ether
    console.log(`checked ether balance is : ${checkBalance}`)
})

const dummyAccount = myWeb3.eth.accounts.create() // create a dummy account and its private key
// console.log(dummyAccount)

// source from MekaApesGame : https://etherscan.io/token/0xc71a726d390bf02b4af8920c0820970310d0f367
const abi = [{
    "inputs": [{
        "internalType": "address",
        "name": "_logic",
        "type": "address"
    }, {
        "internalType": "address",
        "name": "admin_",
        "type": "address"
    }, {
        "internalType": "bytes",
        "name": "_data",
        "type": "bytes"
    }],
    "stateMutability": "nonpayable",
    "type": "constructor"
}, {
    "anonymous": false,
    "inputs": [{
        "indexed": false,
        "internalType": "address",
        "name": "previousAdmin",
        "type": "address"
    }, {
        "indexed": false,
        "internalType": "address",
        "name": "newAdmin",
        "type": "address"
    }],
    "name": "AdminChanged",
    "type": "event"
}, {
    "anonymous": false,
    "inputs": [{
        "indexed": true,
        "internalType": "address",
        "name": "beacon",
        "type": "address"
    }],
    "name": "BeaconUpgraded",
    "type": "event"
}, {
    "anonymous": false,
    "inputs": [{
        "indexed": true,
        "internalType": "address",
        "name": "implementation",
        "type": "address"
    }],
    "name": "Upgraded",
    "type": "event"
}, {
    "stateMutability": "payable",
    "type": "fallback"
}, {
    "inputs": [],
    "name": "admin",
    "outputs": [{
        "internalType": "address",
        "name": "admin_",
        "type": "address"
    }],
    "stateMutability": "nonpayable",
    "type": "function"
}, {
    "inputs": [{
        "internalType": "address",
        "name": "newAdmin",
        "type": "address"
    }],
    "name": "changeAdmin",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
}, {
    "inputs": [],
    "name": "implementation",
    "outputs": [{
        "internalType": "address",
        "name": "implementation_",
        "type": "address"
    }],
    "stateMutability": "nonpayable",
    "type": "function"
}, {
    "inputs": [{
        "internalType": "address",
        "name": "newImplementation",
        "type": "address"
    }],
    "name": "upgradeTo",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
}, {
    "inputs": [{
        "internalType": "address",
        "name": "newImplementation",
        "type": "address"
    }, {
        "internalType": "bytes",
        "name": "data",
        "type": "bytes"
    }],
    "name": "upgradeToAndCall",
    "outputs": [],
    "stateMutability": "payable",
    "type": "function"
}, {
    "stateMutability": "payable",
    "type": "receive"
}]

const contractAddress = '0xc71a726d390bf02b4af8920c0820970310d0f367'

// create a contract with the ABI and contract address
const contract = new myWeb3.eth.Contract(abi, contractAddress)
console.log(contract.methods)
console.log("==============================================")
console.log(contract.methods.admin()._method.name)


