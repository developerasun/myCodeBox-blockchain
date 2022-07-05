const dotenv = require('dotenv')
const { default: pinataClient } = require('@pinata/sdk')
const pinataSDK = require('@pinata/sdk')
const sampleMetadata = require('./sampleMetadata.json')
const fs = require('fs')
const path = require('path')

dotenv.config({ path: './.env' })

const pinata = pinataSDK(process.env.API_PINATA_KEY, process.env.API_PINATA_SECRET)

// console.dir(pinata);

const initTestAuth = async () => {
    const result = await pinata.testAuthentication()
    console.log(result) // should be authenticated
}

initTestAuth()

const metadataFilter = {
    name: 'ipfs',
    keyvalues: {
        company: {
            value: 'exampleCompany',
            op: 'eq',
        },
        total: {
            value: 500,
            secondValue: 1000,
            op: 'between',
        },
    },
}

const filter = {
    status: 'unpinned',
    metadata: metadataFilter,
}

const getPinlist = async () => {
    const pins = await pinata.pinList(filter)
    console.log(pins) // returns an object with count and rows
}

getPinlist()

const getTotalDataSizeInBytes = async () => {
    const size = await pinata.userPinnedDataTotal(process.env.API_PINATA_KEY, process.env.API_PINATA_SECRET)
    console.log(size)
}

getTotalDataSizeInBytes()

const hashMetadata = async () => {
    const result = await pinata.hashMetadata(
        process.env.API_PINATA_SAMPLE_CID,
        sampleMetadata // update existing pin info with the sampleMetadata
    )
    console.log(result) // http request 200 ok response
}

hashMetadata()

const readableFileStream = fs.createReadStream('./sample-image.png')

const pinFileToIPFS = async () => {
    const response = await pinata.pinFileToIPFS(readableFileStream, filter)
    console.log(response)
}

pinFileToIPFS()

const sourceDir = path.join(__dirname, 'test-dir').slice(2).split('\\').join('/')

const pinFromFS = async () => {
    try {
        const response = await pinata.pinFromFS(sourceDir, filter)
        console.log(response)
    } catch (err) {
        throw new Error(err)
    }
}

pinFromFS()

const searchPinataQueue = async () => {
    const response = await pinata.pinJobs({
        sort: 'ASC',
        status: 'searching',
        limit: 10,
    })
    console.log(response)
}

searchPinataQueue()

const sendJSONToIPFS = async () => {
    const body = {
        message: 'developerasun in the building',
    }
    const options = {
        pinataMetadata: {
            name: 'this will be filename',
            keyvalues: {
                customKey: 'hehe',
            },
        },
        pinataOptions: {
            cidVersion: 1,
        },
    }
    try {
        const response = await pinata.pinJSONToIPFS(body, options)
        console.log(response)
    } catch (err) {
        throw new Error(err.message)
    }
}

sendJSONToIPFS()

const unpin = async () => {
    const response = await pinata.unpin('Qmb68XjefoE6P8nSNZNdBym5ehbJTPEWqtGzi3w4uRnfcZ')
    console.log(response) // should be OK
}

unpin()
