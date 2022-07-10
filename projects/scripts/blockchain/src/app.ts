import CryptoJS from "crypto-js";

/* 

# Block data type 
1) hash: its own hash. considered it id. calculated with below arguments.
2) previous hash: the hash from previous block, which is linked with this block.
3) index: its own index/order in blockchain array
4) data: its own transaction data
5) timestamp: its own date when it is mined

# Blockchain validation check
1) current block's hash === calculated current block hash
2) current block's previous hash === previous block's hash

*/

interface BlockProps {
  _index: number;
  _timestamp: string;
  _data: any;
  _previousHash: string;
}

class Block {
  index: number;
  timestamp: string;
  data: any;
  previousHash: string;
  hash: any;
  constructor({ _index, _timestamp, _data, _previousHash = "" }: BlockProps) {
    this.index = _index;
    this.timestamp = _timestamp;
    this.data = _data;
    this.previousHash = _previousHash;
    this.hash = this.calculateHash();
  }

  calculateHash() {
    return CryptoJS.SHA256(
      this.index +
        this.previousHash +
        this.timestamp +
        JSON.stringify(this.data)
    ).toString();
  }
}

class Blockchain {
  blockchain: Block[];

  constructor() {
    this.blockchain = [this.createGenesisBlock()];
  }

  createGenesisBlock() {
    return new Block({
      _index: 0,
      _timestamp: "20220710",
      _data: "Jake Sung inits blockchain",
      _previousHash: "0",
    });
  }

  getLatestBlock() {
    return this.blockchain[this.blockchain.length - 1];
  }

  addBlock(newBlock: Block) {
    newBlock.previousHash = this.getLatestBlock().hash;
    newBlock.hash = newBlock.calculateHash();
    this.blockchain.push(newBlock);
  }

  isChainValid() {
    for (let i = 1; i < this.blockchain.length; i++) {
      const current = this.blockchain[i];
      const previous = this.blockchain[i - 1];

      if (current.hash !== current.calculateHash()) return false;
      if (current.previousHash !== previous.hash) return false;
    }
    return true;
  }

  validOnlyCurrent() {
    const validCurrentHash = this.blockchain.every((block) => {
      return block.hash === block.calculateHash();
    });
    return validCurrentHash;
  }
}

let jake = new Blockchain();

jake.addBlock(
  new Block({
    _index: 1,
    _data: JSON.stringify({ price: 100, signer: "jake" }),
    _timestamp: "right now",
    _previousHash: jake.blockchain[0].hash,
  })
);

jake.addBlock(
  new Block({
    _index: 2,
    _data: JSON.stringify({ price: 200, signer: "jake" }),
    _timestamp: "next day",
    _previousHash: jake.blockchain[1].hash,
  })
);

console.log("chain valid?:", jake.isChainValid());

console.log(
  "%capp.ts line:91 jake.validOnlyCurrent",
  "color: #007acc;",
  jake.validOnlyCurrent()
); // true

// tampering blockchain
jake.blockchain[1].data = JSON.stringify({ price: 1000, signer: "brian" });
jake.blockchain[1].hash = jake.blockchain[1].calculateHash();

console.log(
  "%capp.ts line:103 jake.validOnlyCurrent",
  "color: #007acc;",
  jake.validOnlyCurrent() // true
);

console.log(
  "%capp.ts line:110 jake.isChainValid()",
  "color: #007acc;",
  jake.isChainValid() // false
);
