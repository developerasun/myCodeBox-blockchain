import Web3 from 'web3'
import { PROVIDER, dummies } from '../../config/key.js'
import HDWalletProvider from '@truffle/hdwallet-provider'
import fs from 'fs'
// import .json file is not directly supported as of 2022 Feb
// alternative : 1) read json file 2. convert to string 3) convert to js object
let myContract = fs.readFileSync('./build/contracts/MyContract.json').toString()
myContract = JSON.parse(myContract)

const address = dummies.account1.address
const pk = dummies.account1.privateKey

const checkTestnetBalance = () => {
    const web3 = new Web3(PROVIDER.INFURA.TESTNET)
    web3.eth.getBalance(address, function(error, result) {
        if (error) console.log(error)
        else console.log("current balance : ", web3.utils.fromWei(result, 'ether'), "ether")
    });
}

const init = async () => {
    try {
        // HDWalletProvider is used to send a signed transaction, which 
        // requires a private key. HDWalletProvider is used in server-side
        // In client-side, metamask is used to check user sign.
        const provider = new HDWalletProvider(pk, PROVIDER.INFURA.TESTNET)

        const web3 = new Web3(provider)
        
        // create a contract instance
        let contract = new web3.eth.Contract(myContract.abi)

        // deploy the contract
        contract = await contract
            .deploy({ data : myContract.bytecode })
            .send({ from : address })
        
        // call setter functions from the contract
        await contract.methods.setData(100).send({ from : address })

        // call getter functions from the contract
        const result = await contract.methods.getData().call()

        // check result ropsten etherscan : https://ropsten.etherscan.io/address/0x355bd08011db289dAb96d482C417683F8E41f37c
        console.log(result, "is deployed at", contract.options.address)

    } catch (err) {
        console.log(err)
    }
}

// checkTestnetBalance()
init()