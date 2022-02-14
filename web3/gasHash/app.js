import Web3 from "web3";
import { web3Key } from "../config/key.js";

// connecting to Ropsten Mainnet
const web3 = new Web3(web3Key.INFURA.MAINNET)

// get current gas fee from network
web3.eth.getGasPrice(async function(error, result) {
    console.log(web3.utils.fromWei(result, 'ether'))
});

// hashing with web3
console.log(web3.utils.sha3('Jake Sung')) 
console.log(web3.utils.keccak256('Jake Sung')) // same with above
console.log(web3.utils.soliditySha3('Jake Sung')) // same with above
