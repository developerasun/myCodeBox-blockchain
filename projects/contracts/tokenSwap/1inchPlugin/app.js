import dotenv from "dotenv";
import { createRequire } from "module";
const require = createRequire(import.meta.url);
const Moralis = require("moralis/node"); // Moralis has two versions: 1) browser 2) nodejs

// MEMO: 20220714 => failed to initiate moralis sdk

const DOTENV_ROOT_PATH =
  "C:/Users/nello/go/src/github.com/designerasun/myCodeBox-blockchain/projects/.env";

dotenv.config({ path: DOTENV_ROOT_PATH });
console.log(process.env.API_MORALIS_APP_ID);
// Moralis.initialize(process.env.API_MORALIS_APP_ID);
Moralis.serverURL = process.env.API_MORALIS_DAPP_URL;
Moralis.moralisSecret = process.env.API_MORALIS_MORALIS_SECRET;
console.log(Moralis.serverURL);

let dex;

async function initDex() {
  try {
    if (window) {
      console.log("use node js");
    } else {
      await Moralis.start({
        serverUrl: process.env.API_MORALIS_DAPP_URL,
        appId: process.env.API_MORALIS_APP_ID,
        masterKey: process.env.API_MORALIS_MASTER_KEY,
        moralisSecret: process.env.API_MORALIS_MORALIS_SECRET,
      });

      // Enable web3
      await Moralis.enableWeb3({
        //ETH mainnet
        chainId: 0x03,
        privateKey: process.env.PRIVATE_KEY,
      });

      // sending 0.5 DAI tokens with 18 decimals on BSC mainnet
      const options = {
        type: "erc20",
        amount: Moralis.Units.Token("0.5", 18),
        receiver: "0xEcAB21327B6EbA1FB0631Dc9bBc5863B6B2be3E4",
        contractAddress: "0x31F42841c2db5173425b5223809CF3A38FEde360",
      };

      await Moralis.transfer(options).then((result) => {
        console.log(result);
      });
    }
  } catch (err) {
    console.log(err);
  }

  //   await Moralis.initPlugins(); // enable 1 inch plugin
  //   dex = Moralis.Plugins.oneInch; // dex instanc

  //   /*
  //   dex:
  //   {
  //   diagnostic: [AsyncFunction (anonymous)],
  //   approve: [AsyncFunction (anonymous)],
  //   hasAllowance: [AsyncFunction (anonymous)],
  //   quote: [AsyncFunction (anonymous)],
  //   swap: [AsyncFunction (anonymous)],
  //   getSupportedTokens: [AsyncFunction (anonymous)]
  // }

  //   */

  //   const tokens = await Moralis.Plugins.oneInch.getSupportedTokens({
  //     chain: "bsc", // The blockchain you want to use (eth/bsc/polygon)
  //   });
  //   // console.log(tokens);

  //   const receipt = await dex.swap({
  //     chain: "eth", // The blockchain you want to use (eth/bsc/polygon)
  //     fromTokenAddress: process.env.ROPSTEN_DAI, // The token you want to swap
  //     toTokenAddress: process.env.ROPSTEN_UNI, // The token you want to receive
  //     amount: "10",
  //     fromAddress: process.env.ROPSTEN_ACCOUNT_METAMASK, // Your wallet address
  //     slippage: 1,
  //   });
  //   console.log(receipt);
  //   //   console.log(Object.values(await dex.getSupportedTokens({ chain: "eth" })));

  //   //   const NATIVE_ADDRESS = "0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE";
  //   //   const ONEINCH_ADDRESS = "0x111111111117dc0aa78b770fa6a738034120c302";

  //   //   const options = {
  //   //     chain: "eth",
  //   //     fromTokenAddress: NATIVE_ADDRESS,
  //   //     toTokenAddress: ONEINCH_ADDRESS,
  //   //     amount: Number(Moralis.Units.ETH("0.01")),
  //   //     fromAddress: Moralis.User.current().get("ethAddress"),
  //   //     slippage: 1,
  //   //   };

  //   //   const receipt = await dex.swap(options);
  //   //   console.log(receipt);

  //   const quote = await dex.quote();
  //   console.log(quote);
}

initDex();
