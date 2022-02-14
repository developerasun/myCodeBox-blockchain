import Web3 from "web3";
// import Transaction from "@ethereumjs/tx";
import { web3Key, dummies } from "../../config/key.js";

// provide ethereum testnet ropsten
const web3 = new Web3(web3Key.INFURA.ROPSTEN)

// import dummy accounts
const account1 = dummies.account1.address
const account2 = dummies.account2.address

// import dummy accounts' PK. PK should be in hexadecimal
// A Buffer is similar to an array of integers but corresponds to a raw memory allocation outside the V8 heap
const PK1 = dummies.account1.privateKey
const PK2 = dummies.account2.privateKey

// check dummy account balance
web3.eth.getBalance(account1, (err, bal) => {
    console.log(web3.utils.fromWei(bal, 'ether'))
})

// set transaction details
const txObject = {

    to : account2,
    // value needs to be in wei, which is the smallest Ethereum unit
    value : web3.utils.toWei('0.01', 'ether'),  // send 0.01 ETH

    // transaction commission threshold
    gas : '21000', 
    gasPrice : web3.utils.toWei('10', 'gwei')
}

// broadcast transaction
const signedTransaction = web3.eth.accounts.signTransaction(txObject, PK1)
signedTransaction.then(signedTx => {
    const sentTx = web3.eth.sendSignedTransaction(signedTx.rawTransaction)
    sentTx.on("receipt", receipt => {
        console.log("receipt : ", receipt)
    })
    sentTx.on("error", error => {
        console.log("error : ", error)
    })
})