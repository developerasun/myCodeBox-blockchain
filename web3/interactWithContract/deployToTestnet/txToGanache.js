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

const checkPrevBalance = () => {
    const web3 = new Web3(PROVIDER.GANACHE)
    web3.eth.getBalance(address, function(error, result) {
        if (error) console.log(error)
        else console.log(web3.utils.fromWei(result, 'ether'))
    });
}

const chargeGanacheFunds = () => {
    const web3 = new Web3(PROVIDER.GANACHE)
    web3.eth.sendTransaction({
        from : '0x3fdA52C0Fd1257F29014B8A23FF01b82f8E643Ab', // first account of GANACHE
        to : address, 
        value : web3.utils.toWei('1', 'ether')  // from ganache fund
    });
}

const init = async () => {
    try {
        // HDWalletProvider is used to send a signed transaction, which 
        // requires a private key. HDWalletProvider is used in server-side
        // In client-side, metamask is used to check user sign.
        const provider = new HDWalletProvider(pk, PROVIDER.GANACHE)

        const web3 = new Web3(provider)
        const id = await web3.eth.net.getId()
        const deployedNetwork = myContract.networks[id]

        // create a contract instance
        const contract = new web3.eth.Contract(myContract.abi, deployedNetwork.address)
    
        // send the transaction
        await contract.methods.setData(20).send({
            from : address
        })    

        // read the trasaction
        const result = await contract.methods.getData().call()
        console.log(result)
    } catch (err) {
        console.log(err)
    }
}

chargeGanacheFunds()
init()