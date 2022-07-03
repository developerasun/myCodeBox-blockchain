import { BigNumber } from 'ethers'

console.log('hello')

// const wallet = new e
// console.log(wallet)
const myBig = BigNumber.from(222)
console.log(myBig._isBigNumber)
console.log(myBig._hex)

console.log('max int is : ', Number.MAX_SAFE_INTEGER)
