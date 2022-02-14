import Web3 from "web3";
import { web3Key, dummies } from "../config/key.js";

// connecting to Ropsten testnet
const web3 = new Web3(web3Key.INFURA.ROPSTEN)

const sender = dummies.account1.address
const senderPK = dummies.account1.privateKey

const receiver = dummies.account2.address
const receiverPK = dummies.account2.privateKey

// check ganache test transaction gas price
console.log(web3.utils.fromWei('558056', 'ether'))