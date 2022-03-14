# Learning OpenZeppelin essentials 
## ERC20
> There a few core contracts that implement the behavior specified in the EIP

1. IERC20: the interface all ERC20 implementations should conform to.
1. IERC20Metadata: the extended ERC20 interface including the name, symbol and decimals functions.
1. ERC20: the implementation of the ERC20 interface, including the name, symbol and decimals optional standard extension to the base interface.

## ERC721
> The EIP specifies four interfaces:

1. IERC721: Core functionality required in all compliant implementation.
1. IERC721Metadata: Optional extension that adds name, symbol, and token URI, almost always included.
1. IERC721Enumerable: Optional extension that allows enumerating the tokens on chain, often not included since it requires large gas overhead.
1. IERC721Receiver: An interface that must be implemented by contracts if they want to accept tokens through safeTransferFrom.

> OpenZeppelin Contracts provides implementations of all four interfaces:

1. ERC721: The core and metadata extensions, with a base URI mechanism.
1. ERC721Enumerable: The enumerable extension.
1. ERC721Holder: A bare bones implementation of the receiver interface.

## Access control
> Access control—that is, "who is allowed to do this thing"—is incredibly important in the world of smart contracts. The access control of your contract may govern who can mint tokens, vote on proposals, freeze transfers, and many other things. It is therefore critical to understand how you implement it, lest someone else steals your whole system.

### Ownership
> The most common and basic form of access control is the concept of ownership: there’s an account that is the owner of a contract and can do administrative tasks on it. This approach is perfectly reasonable for contracts that have a single administrative user.

```solidity
// contracts/MyContract.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract MyContract is Ownable {
    function normalThing() public {
        // anyone can call this normalThing()
    }

    function specialThing() public onlyOwner {
        // only the owner can call specialThing()!
    }
}
```

> By default, the owner of an Ownable contract is the account that deployed it, which is usually exactly what you want.

### Multi-signature
> Note that a contract can also be the owner of another one! This opens the door to using, for example, a Gnosis Multisig or Gnosis Safe, an Aragon DAO, an ERC725/uPort identity contract, or a totally custom contract that you create.

> In this way you can use composability to add additional layers of access control complexity to your contracts. Instead of having a single regular Ethereum account (Externally Owned Account, or EOA) as the owner, you could use a 2-of-3 multisig run by your project leads, for example. Prominent projects in the space, such as MakerDAO, use systems similar to this one.

### Role-based access control
> While the simplicity of ownership can be useful for simple systems or quick prototyping, different levels of authorization are often needed. You may want for an account to have permission to ban users from a system, but not create new tokens. Role-Based Access Control (RBAC) offers flexibility in this regard.

> In essence, we will be defining multiple roles, each allowed to perform different sets of actions. An account may have, for example, 'moderator', 'minter' or 'admin' roles, which you will then check for instead of simply using onlyOwner. This check can be enforced through the onlyRole modifier. Separately, you will be able to define rules for how accounts can be granted a role, have it revoked, and more.

> Most software uses access control systems that are role-based: some users are regular users, some may be supervisors or managers, and a few will often have administrative privileges.

> OpenZeppelin Contracts provides AccessControl for implementing role-based access control. Its usage is straightforward: for each role that you want to define, you will create a new role identifier that is used to grant, revoke, and check if an account has that role.

> where AccessControl shines is in scenarios where granular permissions are required, which can be implemented by defining multiple roles.

```solidity 
// contracts/MyToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    constructor(address minter, address burner) ERC20("MyToken", "TKN") {
        _setupRole(MINTER_ROLE, minter);
        _setupRole(BURNER_ROLE, burner);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyRole(BURNER_ROLE) {
        _burn(from, amount);
    }
}
```

#### Granting and revoking roles
```solidity 
// contracts/MyToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    constructor(address minter, address burner) ERC20("MyToken", "TKN") {
        // Grant the contract deployer the default admin role: it will be able to grant and revoke any roles
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyRole(BURNER_ROLE) {
        _burn(from, amount);
    }
}
```

> Note that, unlike the previous examples, no accounts are granted the 'minter' or 'burner' roles. However, because those roles' admin role is the default admin role, and that role was granted to msg.sender, that same account can call grantRole to give minting or burning permission, and revokeRole to remove it.

> Dynamic role allocation is often a desirable property, for example in systems where trust in a participant may vary over time. It can also be used to support use cases such as KYC, where the list of role-bearers may not be known up-front, or may be prohibitively expensive to include in a single transaction.

## Upgradable smart contract
> Smart contracts in Ethereum are immutable by default. Once you create them there is no way to alter them, effectively acting as an unbreakable contract among participants.

> However, for some scenarios, it is desirable to be able to modify them. Think of a traditional contract between two parties: if they both agreed to change it, they would be able to do so. On Ethereum, they may desire to alter a smart contract to fix a bug they found (which might even lead to a hacker stealing their funds!), to add additional features, or simply to change the rules enforced by it.

Overall workflow to write, upgrade, and deploy a upgradable contract is as follows : 

1. Write upgradable contracts with @openzeppelin/contracts-upgradeable. 
1. Test the contracts. 
1. Upgrade and deploy the contracts with @openzeppelin/hardhat-upgrades.

> OpenZeppelin provides tooling for deploying and securing upgradeable smart contracts.

1. Upgradeable Contracts to build your contract using our Solidity components.
1. Upgrades Plugins to deploy upgradeable contracts with automated security checks.
1. Defender Admin to manage upgrades in production and automate operations.

You will need these dependencies for upgradable smart contract.

```shell
# upgradable contracts dependency
$npm i @openzeppelin/contracts-upgradeable # writing upgradable contracts
$npm i @openzeppelin/hardhat-upgrades # deploying and upgrading the contracts
$npm i @nomiclabs/hardhat-ethers 
$npm i ethers
```

### Using with upgrades
> If your contract is going to be deployed with upgradeability, such as using the OpenZeppelin Upgrades Plugins, you will need to use the Upgradeable variant of OpenZeppelin Contracts.

> This variant is available as a separate package called @openzeppelin/contracts-upgradeable, which is hosted in the repository OpenZeppelin/openzeppelin-contracts-upgradeable.

> It follows all of the rules for Writing Upgradeable Contracts: 

1. constructors are replaced by initializer functions
1. state variables are initialized in initializer functions

> and we additionally check for storage incompatibilities across minor versions.

Install it like below. 

```shell
$npm install @openzeppelin/contracts-upgradeable
```

> The package replicates the structure of the main OpenZeppelin Contracts package, but every file and contract has the suffix Upgradeable.

```
-import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
+import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";

-contract MyCollectible is ERC721 {
+contract MyCollectible is ERC721Upgradeable {
```

> Constructors are replaced by internal initializer functions following the naming convention __{ContractName}_init. Since these are internal, you must always define your own public initializer function and call the parent initializer of the contract you extend.

```
-    constructor() ERC721("MyCollectible", "MCO") public {
+    function initialize() initializer public {
+        __ERC721_init("MyCollectible", "MCO");
    }
```

> Once this contract is set up and compiled, you can deploy it using the Upgrades Plugins. The following snippet shows an example deployment script using Hardhat.

```js
// scripts/deploy-my-collectible.js
const { ethers, upgrades } = require("hardhat");

async function main() {
  const MyCollectible = await ethers.getContractFactory("MyCollectible");

  const mc = await upgrades.deployProxy(MyCollectible);

  await mc.deployed();
  console.log("MyCollectible deployed to:", mc.address);
}

main();
```

#### Multiple inheritance
> Initializer functions are not linearized by the compiler like constructors. Because of this, each __{ContractName}_init function embeds the linearized calls to all parent initializers. As a consequence, calling two of these init functions can potentially initialize the same contract twice.

> The function __{ContractName}_init_unchained found in every contract is the initializer function minus the calls to parent initializers, and can be used to avoid the double initialization problem, but doing this manually is not recommended. We hope to be able to implement safety checks for this in future versions of the Upgrades Plugins.

#### Storage gaps
> You may notice that every contract includes a state variable named __gap. This is empty reserved space in storage that is put in place in Upgradeable contracts. It allows us to freely add new state variables in the future without compromising the storage compatibility with existing deployments.

> It isn’t safe to simply add a state variable because it "shifts down" all of the state variables below in the inheritance chain. This makes the storage layouts incompatible, as explained in Writing Upgradeable Contracts. The size of the __gap array is calculated so that the amount of storage used by a contract always adds up to the same number (in this case 50 storage slots).

### Upgrades plugins
> Integrate upgrades into your existing workflow. Plugins for Hardhat and Truffle to deploy and manage upgradeable contracts on Ethereum. Upgrades Plugins are only a part of a comprehensive set of OpenZeppelin tools for deploying and securing upgradeable smart contracts. Check out the full list of resources.

1. Deploy upgradeable contracts.
1. Upgrade deployed contracts.
1. Manage proxy admin rights.
1. Easily use in tests.

Install the plugin like below. 

```shell
# hardhat
$npm install --save-dev @openzeppelin/hardhat-upgrades @nomiclabs/hardhat-ethers ethers
# truffle
$npm install --save-dev @openzeppelin/truffle-upgrades
```

And then load the package in config.

```js 
// hardhat.config.js
require('@openzeppelin/hardhat-upgrades');
// hardhat.config.ts
import '@openzeppelin/hardhat-upgrades';
```

> Hardhat users will be able to write scripts that use the plugin to deploy or upgrade a contract, and manage proxy admin rights.

```js
const { ethers, upgrades } = require("hardhat");

async function main() {
    const Box = await ethers.getContractFactory("Box");
    // Deploying with proxy
    const instance = await upgrades.deployProxy(Box, [42]);
    await instance.deployed();

    // Upgrading
    const BoxV2 = await ethers.getContractFactory("BoxV2");
    const upgraded = await upgrades.upgradeProxy(instance.address, BoxV2);
}

main();
```

> deployProxy does the following:

1. Validate that the implementation is upgrade safe.
1. Deploy a proxy admin for your project (if needed).
1. Deploy the implementation contract.
1. Create and initialize the proxy contract.

> upgradeProxy does the following:

1. Validate that the new implementation is upgrade safe and is compatible with the previous one.
1. Check if there is an implementation contract deployed with the same bytecode, and deploy one if not.
1. Upgrade the proxy to use the new implementation contract.

> Truffle users will be able to write migrations that use the plugin to deploy or upgrade a contract, or manage proxy admin rights.

```js 
const { deployProxy, upgradeProxy } = require('@openzeppelin/truffle-upgrades');

const Box = artifacts.require('Box');
const BoxV2 = artifacts.require('BoxV2');

module.exports = async function (deployer) {
  const instance = await deployProxy(Box, [42], { deployer });
  const upgraded = await upgradeProxy(instance.address, BoxV2, { deployer });
}
```

> Whether you’re using Hardhat or Truffle, you can use the plugin in your tests to ensure everything works as expected.

> The plugins will keep track of all the implementation contracts you have deployed in an .openzeppelin folder in the project root, as well as the proxy admin. You will find one file per network there. It is advised that you commit to source control the files for all networks except the development ones (you may see them as .openzeppelin/unknown-*.json)

### Proxy pattern
> The plugins support the UUPS, transparent, and beacon proxy patterns. UUPS and transparent proxies are upgraded individually, whereas any number of beacon proxies can be upgraded atomically at the same time by upgrading the beacon that they point to. For more details on the different proxy patterns available, see the documentation for Proxies.

> For UUPS and transparent proxies, use deployProxy and upgradeProxy as shown above. For beacon proxies, use deployBeacon, deployBeaconProxy, and upgradeBeacon. See the documentation for Hardhat Upgrades and Truffle Upgrades for examples.

## Reference
- [OpenZeppelin docs](https://docs.openzeppelin.com/)
- [OpenZeppelin docs : upgradable smart contract](https://docs.openzeppelin.com/learn/upgrading-smart-contracts#whats-in-an-upgrade)