const HelloWorld = artifacts.require('HelloWorld')

// in each contract test, contract gets deployed with a clean state
// accounts parameter points to Truffle's default 10 dummy accounts. 
contract('HelloWorld', accounts => {
    it('should get message', async () => {
        // create a deployed contract instance
        let instance = await HelloWorld.deployed()
        let message = await instance.message() // note that state variable is called as method here
        assert.equal(message, 'hello world constructor')
    })
    
    it('owner should be accounts[0]', async () => {
        // create a deployed contract instance
        let instance = await HelloWorld.deployed()
        let owner = await instance.owner() // note that state variable is called as method here
        assert.equal(owner, accounts[0])
    })
    
    it('should return 1 ether', async () => {
        let instance = await HelloWorld.deployed()
        // web3 is available in Truffle
        assert.equal(web3.utils.fromWei('1000000000000000000', 'ether'), '1')
    })
})