const Web3 = require('web3')
const PROVIDER = require('../../config/key.js')
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
        const receipt = await contract.methods.emitEvent('goodbye event').send({
            from : addresses[0],
        })
        // console.log(receipt)
        // console.log(receipt.events) // events property contains Events in transaction
        // console.log(receipt.events.MyEvent.returnValues) // typically returnValues is used to inspect tx logs

        // get past events for this contract
        const results = await contract.getPastEvents(
            'allEvents', 
            {
                filter : {
                    // value property is searchable since it is indexed
                    value : 'goodbye event'
                }, 
                fromBlock : 0, 
                toBlock : 'latest'
            }
        )
        console.log(results)
    } catch (err) {
        console.log(err)
    }
}

init()