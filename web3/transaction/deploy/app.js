import Web3 from "web3";
import { web3Key, dummies } from "../../config/key.js";

// connecting to Ropsten testnet
const web3 = new Web3(web3Key.INFURA.ROPSTEN)

const sender = dummies.account1.address
const senderPK = dummies.account1.privateKey

const receiver = dummies.account2.address
const receiverPK = dummies.account2.privateKey

// create transaction object
const txObject = { 
    to : receiver,
    value : web3.utils.toWei('0.01', 'ether'), // send 0.01 ether
    gas : '21000',
    gasPrice : web3.utils.toWei('10', 'gwei')
}

console.log(web3.utils.fromWei('558056', 'ether'))

// sign the tramsaction
const signedTx = web3.eth.accounts.signTransaction(txObject, senderPK)

// broadcast the transaction
signedTx.then((signed) => {
    // send the signed transaction
    const sentTx = web3.eth.sendSignedTransaction(signed.rawTransaction)

    // check result
    sentTx.on("receipt", (receipt) => console.log(receipt))
    sentTx.on("error", (error) => console.log(error))
})