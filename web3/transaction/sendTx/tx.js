import Web3 from 'web3'
import Transaction from '@ethereumjs/tx'
import { GANACHE } from '../../config/key'

// Up and running Ganache 
const web3 = new Web3(GANACHE.SERVER)

// Get some accounts 
const account1 = '0x9E6C43796215BEC2a95A4fBD07911eed7A254A20'
const account2 = '0xb9390e0fD1B13E66C909D97C47CFA5c737a95f12'

const convertToEther = (err, bal) => {
    const toEther = web3.utils.fromWei(bal, 'ether')
    console.log(toEther)
}

// Check balance
web3.eth.getBalance(account1, (err, bal) => {
    console.log(bal)
    const toEther = web3.utils.fromWei(bal, 'ether')
    console.log(toEther)
})

// account 1 : send 5 ethers to account 2
web3.eth.sendTransaction( { 
    from : account1, 
    to : account2, 
    value : web3.utils.toWei('5', 'ether')
})

// check account 1 balance
web3.eth.getBalance(account1, (err, bal) => {
    convertToEther(err, bal)
})

console.log(Transaction)