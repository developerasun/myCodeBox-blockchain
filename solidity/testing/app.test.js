const { add } = require('./app')

// chai provides 3 styles for testing : 1) should 2) expect 3) assert
// choose one based on your preference
const assert = require('chai').assert

describe('test add function', () => {
    it('should add two integers', () => {
        // arrange-act-assert pattern 
        // arrange
        const a = 1
        const b = 2 

        // act
        const result = add(a,b)

        // assert
        assert.equal(result, 3)
    })
})