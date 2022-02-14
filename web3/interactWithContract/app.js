import Web3 from 'web3'
import { PROVIDER } from '../config/key.js'

// provide a provider(API delegation)
// const provider = Web3.providers.HttpProvider(PROVIDER.GANACHE)
// create a web3 provider instance(GANACHE)
const web3 = new Web3(PROVIDER.GANACHE) // connected to blockchain

// contract compiled/deployed by REMIX
const abi = [
    {
        "inputs": [],
        "name": "getName",
        "outputs": [
            {
                "internalType": "bytes32",
                "name": "",
                "type": "bytes32"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    }
]

const address = "0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8"

// provide contract address and abi to Web3 instance
const contract = new web3.eth.Contract(
    abi, 
    address // optional
)

// check contract methods
console.log(contract.methods)

// call one of the contract methods
contract.methods.getName().call().then((result)=> console.log(result)).catch((err)=>console.log(err))