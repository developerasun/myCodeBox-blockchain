# Learning Geth essentials

## Getting Started with Geth

> The tutorial on this page assumes Geth and the associated developer tools have been installed successfully.

> This page provides step-by-step instructions covering the fundamentals of using Geth. This includes generating accounts, joining an Ethereum network, syncing the blockchain and sending ether between accounts. This tutorial also uses Clef. Clef is an account management tool external to Geth itself that allows users to sign transactions. It is developed and maintained by the Geth team and is intended to eventually replace the account management tool built in to Geth.

## Background 

> In order to use Ethereum, it is first necessary to generate an EOA (hereafter, “account”). This tutorial will guide the user through creating an account, funding it with ether and sending some to another address.

> Geth is an Ethereum client written in Go. This means running Geth turns a computer into an Ethereum node. Ethereum is a peer-to-peer network where information is shared directly between nodes rather than being managed by a central server. Nodes compete to generate new blocks of transactions to send to its peers because they are rewarded for doing so in Ethereum’s native token, ether (ETH). On receiving a new block, each node checks that it is valid and adds it to their database. The sequence of discrete blocks is called a “blockchain”. 

> The information provided in each block is used by Geth to update its “state” - the ether balance of each account on Ethereum. There are two types of account: externally-owned accounts (EOAs) and contract accounts. Contract accounts execute contract code when they receive transactions. EOAs are accounts that users manage locally in order to sign and submit transactions. Each EOA is a public-private key pair, where the public key is used to derive a unique address for the user and the private key is used to protect the account and securely sign messages

> There are several methods for generating accounts in Geth. This tutorial demonstrates how to generate accounts using Clef, as this is considered best practice, largely because it decouples the users’ key management from Geth, making it more modular and flexible. It can also be run from secure USB sticks or virtual machines, offering security benefits. For convenience, this tutorial will execute Clef on the same computer that will also run Geth, although more secure options are available (see here).

> An account is a pair of keys (public and private). Clef needs to know where to save these keys to so that they can be retrieved later. This information is passed to Clef as an argument. This is achieved using the following command:

```shell
$clef newaccount --keystore geth-tutorial/keystore
```

> The specific function from Clef that generates new accounts is newaccount and it accepts a parameter, --keystore, that tells it where to store the newly generated keys. In this example the keystore location is a new directory that will be created automatically: geth-tutorial/keystore. Clef will return the following result in the terminal:




## Reference

- https://geth.ethereum.org/docs/getting-started