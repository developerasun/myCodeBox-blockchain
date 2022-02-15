const Web3 = require('web3')
const PROVIDER = require('../../config/key.js')
const myContract = require('./build/contracts/MyContract.json')

const init = async () => {
    try {
        // set provider
        const web3 = new Web3(PROVIDER.PROVIDER.GANACHE)

        // get network id and network object
        const id = await web3.eth.net.getId() 
        console.log("network id is : ", id) // 5777 is GANACHE network id

        const deployedNetwork = myContract.networks[id]
        console.log(deployedNetwork)

        // create a contract instance : abi, address 
        const contract = new web3.eth.Contract(myContract.abi, deployedNetwork.address)
        
        // get accounts from provider
        const addresses = await web3.eth.getAccounts()
        console.log("first account of GANACHE : ", addresses[0])

        // call setData method in the contract
        await contract.methods.sendEther().send({
            from: addresses[0], // first address of GANACHE
            value : web3.utils.toWei('1', 'ether') // send 1 ether to contract from address[0]
        })
        
        console.log(await contract.methods.functionCalled().call())
    } catch (err) {
        console.log(err)
    }
}

init()