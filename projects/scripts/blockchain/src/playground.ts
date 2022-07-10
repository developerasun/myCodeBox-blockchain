import CryptoJS from "crypto-js";
import { BlockModule } from "./modules";
import type { BlockProps } from "./types";

console.log(CryptoJS.SHA256("hash me").toString());
console.log(CryptoJS.SHA256("ss").words.toString());
console.log(CryptoJS.SHA256("ss").toString());

const myBlock: BlockProps = {
  index: 3,
  previousHash: "33",
  data: "jake",
};

console.log(new Date().toISOString().slice(0, 10)); // date format: yyyy-mm-dd

const date = Date.now();
console.log(date.toString());
console.log(typeof Number(4).toString());

const testBlock = new BlockModule.Block({
  data: { signer: "Jake", privateKey: 123 },
  index: 1,
  previousHash: "",
});

console.log("%cplayground.ts line:21 testBlock", "color: #007acc;", testBlock);

console.log(myBlock);
