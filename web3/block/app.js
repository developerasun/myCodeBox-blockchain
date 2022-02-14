import Web3 from "web3";
import { PROVIDER } from "../config/key.js";

// connecting to Ropsten Mainnet
const web3 = new Web3(PROVIDER.INFURA.MAINNET)

// logging total ethereum mainnet block number
web3.eth.getBlockNumber().then((console.log)) // 14158805
// and the total block number in etherscan.io is : 1,462.65 M (12.3 TPS)

// logging the latest block's hash and difficulty
web3.eth.getBlock(14158805).then(block => {
    console.log( {
        hash : block.hash, 
        difficulty : block.difficulty   
    })
})

// logging the 10 latest block hash
web3.eth.getBlockNumber().then((latest) => {
    for (let i=0; i<10; i++) {
        web3.eth.getBlock(latest-i, true, function(error, result) {
            console.log(result.hash)
        });
    }
})