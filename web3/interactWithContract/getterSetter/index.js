const Web3 = require('web3')
const PROVIDER = require('../../config/key.js')

// import json file is supported in common js
const myContract = require('./build/contracts/MyContract.json')

const init = async () => {
    try {
        const web3 = new Web3(PROVIDER.PROVIDER.GANACHE)
        const id = await web3.eth.net.getId() 
        const deployedNetwork = myContract.networks[id]

        // create a contract instance
        const contract = new web3.eth.Contract(myContract.abi, deployedNetwork.address)
    
        // get accounts from provider
        const addresses = await web3.eth.getAccounts()
        console.log(addresses[0]) // first account of GANACHE

        // call setData method in the contract
        await contract.methods.setData(10).send({
            from : addresses[0],
        })
        
        // call getData method in the contract
        // contract.methods.yourMethod.call : read only function
        const data = await contract.methods.getData().call()
        console.log(data)
    } catch (err) {
        console.log(err)
    }
}

init()