import Web3 from "web3";
import { web3Key, dummies, PASSWORD } from "../config/key.js";

// connecting to Ropsten Mainnet
const web3 = new Web3(web3Key.INFURA.MAINNET)

const account1 = dummies.account1.address
const PK1 = dummies.account1.privateKey

const safePw = web3.eth.accounts.encrypt(PK1, PASSWORD)
console.log(safePw)

const decripted = web3.eth.accounts.decrypt(safePw, PASSWORD)
console.log(decripted.privateKey)

// wallet holds multiple accounts
const wallet = web3.eth.accounts.wallet.create(5)
console.log(wallet)
console.log(wallet.encrypt(PASSWORD))

