import { BlockProps } from "./types";
import CryptoJS from "crypto-js";

export module BlockModule {
  export class Block {
    hash;
    previousHash;
    index;
    data;
    timestamp;
    constructor({ data, previousHash, index }: BlockProps) {
      this.hash = this.caculateHash();
      this.previousHash = previousHash;
      this.index = index;
      this.data = data;
      this.timestamp = new Date().toISOString().slice(0, 10);
    }
    caculateHash() {
      return CryptoJS.SHA256(
        JSON.stringify(this.data) +
          this.timestamp +
          this.previousHash +
          Number(this.index).toString()
      );
    }
  }
  export class Blockchain {
    chain: Block[];
    constructor(_chain: Block[]) {
      this.chain = _chain;
    }
    initGenesisBlock() {
      return new Block({ data: "", index: 0, previousHash: "" });
    }
  }
}
