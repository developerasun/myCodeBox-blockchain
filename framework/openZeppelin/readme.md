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

### Writing upgradable smart contract
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

> When working with upgradeable contracts using OpenZeppelin Upgrades, there are a few minor caveats to keep in mind when writing your Solidity code.

> It’s worth mentioning that these restrictions have their roots in how the Ethereum VM works, and apply to all projects that work with upgradeable contracts, not just OpenZeppelin Upgrades.

#### Initializer
> You can use your Solidity contracts with OpenZeppelin Upgrades without any modifications, except for their constructors. Due to a requirement of the proxy-based upgradeability system, no constructors can be used in upgradeable contracts. 

> This means that, when using a contract with the OpenZeppelin Upgrades, you need to change its constructor into a regular function, typically named initialize, where you run all the setup logic:

```solidity
pragma solidity ^0.6.0;

contract MyContract {
    uint256 public x;
    // To prevent a contract from being initialized multiple times, you need to add a check to ensure the initialize function is called only once
    bool private initialized;

    function initialize(uint256 _x) public {
        require(!initialized, "Contract instance has already been initialized");
        initialized = true;
        x = _x;
    }
}
```

> Since this pattern is very common when writing upgradeable contracts, OpenZeppelin Contracts provides an Initializable base contract that has an initializer modifier that takes care of this:

```solidity
pragma solidity ^0.6.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract MyContract is Initializable {
    uint256 public x;

    function initialize(uint256 _x) public initializer {
        x = _x;
    }
}
```

> Another difference between a constructor and a regular function is that Solidity takes care of automatically invoking the constructors of all ancestors of a contract. When writing an initializer, you need to take special care to manually call the initializers of all parent contracts:

```solidity
pragma solidity ^0.6.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract BaseContract is Initializable {
    uint256 public y;

    function initialize() public initializer {
        y = 42;
    }
}

contract MyContract is BaseContract {
    uint256 public x;

    function initialize(uint256 _x) public initializer {
        BaseContract.initialize(); // Do not forget this call!
        x = _x;
    }
}
```

#### Using Upgradeable Smart Contract Libraries
> Note that you should not be using these contracts, for example ERC20.sol, ERC721.sol, in your OpenZeppelin Upgrades project. Instead, make sure to use @openzeppelin/contracts-upgradeable, which is an official fork of OpenZeppelin Contracts that has been modified to use initializers instead of constructors.

> Whether using OpenZeppelin Contracts or another smart contract library, always make sure that the package is set up to handle upgradeable contracts.

#### Avoiding Initial Values in Field Declarations
> Whilst Solidity allows defining initial values for fields when declaring them in a contract, this will not work for upgradeable contracts.

```solidity
// bad
contract MyContract {
    uint256 public hasInitialValue = 42; // equivalent to setting in the constructor
}

// good
contract MyContract is Initialiaable {
    uint256 public hasInitialValue; // do not initialize state variables here.
    uint256 public constant hasConstantInitialValue = 33; // but constant is good to go.

    function initialize() public initializer {
        hasInitialValue = 42; // set initial value in initializer
    }
}
```

> It is still ok to define constant state variables, because the compiler does not reserve a storage slot for these variables, and every occurrence is replaced by the respective constant expression.

#### Initializing the Implementation Contract
> Do not leave an implementation contract uninitialized. An uninitialized implementation contract can be taken over by an attacker, which may impact the proxy. You can either invoke the initializer manually, or you can include a constructor to automatically mark it as initialized when it is deployed:

```solidity
/// @custom:oz-upgrades-unsafe-allow constructor
constructor() initializer {}
```

#### No selfdestruct and delegatecall
> As such, it is not allowed to use either selfdestruct or delegatecall in your upgradable contracts.

> When working with upgradeable smart contracts, you will always interact with the contract instance, and never with the underlying logic contract. However, nothing prevents a malicious actor from sending transactions to the logic contract directly. This does not pose a threat, since any changes to the state of the logic contracts do not affect your contract instances, as the storage of the logic contracts is never used in your project.

> There is, however, an exception. If the direct call to the logic contract triggers a selfdestruct operation, then the logic contract will be destroyed, and all your contract instances will end up delegating all calls to an address without any code. This would effectively break all contract instances in your project.

> A similar effect can be achieved if the logic contract contains a delegatecall operation. If the contract can be made to delegatecall into a malicious contract that contains a selfdestruct, then the calling contract will be destroyed.

#### Modifying contract, keeping storage layout
> When writing new versions of your contracts, either due to new features or bug fixing, there is an additional restriction to observe: you cannot change the order in which the contract state variables are declared, nor their type.

> Violating any of these storage layout restrictions will cause the upgraded version of the contract to have its storage values mixed up, and can lead to critical errors in your application.

For example, 

```solidity
// initial contract
contract MyContract {
    uint256 private x;
    string private y;
}

// bad : cannot change variable type
contract MyContract {
    string private x;
    string private y;
}

// bad : cannot change variable order
contract MyContract {
    string private y;
    uint256 private x;
}

// bad : cannot introduce a new variable before existing one
contract MyContract {
    bytes private a;
    uint256 private x;
    string private y;
}

// good : can add a new variable at the end
contract MyContract {
    uint256 private x; // existing one
    string private y; // existing one
    bytes private z; // new variable z
}

// bad : cannot remove an existing variable
contract MyContract {
    string private y;
}
```

> Keep in mind that if you rename a variable, then it will keep the same value as before after upgrading. This may be the desired behavior if the new variable is semantically the same as the old one:

```solidity
contract MyContract {
    uint256 private x;
    string private z; // starts with the value from `y`, only name changed
}
```

> And if you remove a variable from the end of the contract, note that the storage will not be cleared. A subsequent update that adds a new variable will cause that variable to read the leftover value from the deleted one.

```solidity
contract MyContract {
    uint256 private x;
    // storage for y is not cleared even though it is deleted.
}

// thus upgraded to
contract MyContract {
    uint256 private x;
    string private z; // starts with the value from `y`
}
```

> Note that you may also be inadvertently changing the storage variables of your contract by changing its parent contracts. Then modifying MyContract by swapping the order in which the base contracts are declared, or introducing new base contracts, will change how the variables are actually stored:

```solidity
// good
contract A {
    uint256 a;
}

contract B {
    uint256 b;
}

contract MyContract is A, B {}

// bad 
contract MyContract is B, A {}

```

> You also cannot add new variables to base contracts, if the child has any variables of its own. Given the following scenario:

```solidity
contract Base {
    uint256 base1;
}

contract Child is Base {
    uint256 child;
}
```

> If Base is modified to add an extra variable:

```solidity
contract Base {
    uint256 base1;
    uint256 base2;
}
```

> Then the variable base2 would be assigned the slot that child had in the previous version. A workaround for this is to declare unused variables on base contracts that you may want to extend in the future, as a means of "reserving" those slots. Note that this trick does not involve increased gas usage.

#### Proxy upgrade pattern
##### Upgrading via Proxy pattern
> The basic idea is using a proxy for upgrades. The first contract is a simple wrapper or "proxy" which users interact with directly and is in charge of forwarding transactions to and from the second contract, which contains the logic. The key concept to understand is that the logic contract can be replaced while the proxy, or the access point is never changed. Both contracts are still immutable in the sense that their code cannot be changed, but the logic contract can simply be swapped by another contract. The wrapper can thus point to a different logic implementation and in doing so, the software is "upgraded".

![openzepplin-proxy](https://user-images.githubusercontent.com/83855174/158337176-fe281f21-27ac-443d-8438-2352a706b800.png)

##### Proxy forwarding
> The most immediate problem that proxies need to solve is how the proxy exposes the entire interface of the logic contract without requiring a one to one mapping of the entire logic contract’s interface. That would be difficult to maintain, prone to errors, and would make the interface itself not upgradeable. Hence, a dynamic forwarding mechanism is required. The basics of such a mechanism are presented in the code below:

```assembly
assembly {
  let ptr := mload(0x40)

  // (1) copy incoming call data
  calldatacopy(ptr, 0, calldatasize)

  // (2) forward call to logic contract
  let result := delegatecall(gas, _impl, ptr, calldatasize, 0, 0)
  let size := returndatasize

  // (3) retrieve return data
  returndatacopy(ptr, 0, size)

  // (4) forward return data back to caller
  switch result
  case 0 { revert(ptr, size) }
  default { return(ptr, size) }
}
```

> This code can be put in the [fallback function](https://solidity.readthedocs.io/en/v0.6.12/contracts.html#fallback-function) of a proxy, and will forward any call to any function with any set of parameters to the logic contract without it needing to know anything in particular of the logic contract’s interface. In essence, (1) the calldata is copied to memory, (2) the call is forwarded to the logic contract, (3) the return data from the call to the logic contract is retrieved, and (4) the returned data is forwarded back to the caller.

> A very important thing to note is that the code makes use of the EVM’s delegatecall opcode which executes the callee’s code in the context of the caller’s state. That is, the logic contract controls the proxy’s state and the logic contract’s state is meaningless. Thus, the proxy doesn’t only forward transactions to and from the logic contract, but also represents the pair’s state. The state is in the proxy and the logic is in the particular implementation that the proxy points to.

### Deploy and test upgradable smart contract 
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

#### Hardhat plugin
> Hardhat users will be able to write scripts that use the plugin to deploy or upgrade a contract, and manage proxy admin rights. Once the contract is set up and compiled, you can deploy it using the Upgrades Plugins. The following snippet shows an example deployment script using Hardhat.

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

> The plugins will keep track of all the implementation contracts you have deployed in an .openzeppelin folder in the project root, as well as the proxy admin. You will find one file per network there. It is advised that you commit to source control the files for all networks except the development ones (you may see them as .openzeppelin/unknown-*.json

##### Test with Hardhat
> You can also use the plugin’s functions from your Hardhat tests, in case you want to add tests for upgrading your contracts (which you should!). The API is the same as in scripts.

```js
const { expect } = require("chai");

describe("Box", function() {
  it('works', async () => {
    const Box = await ethers.getContractFactory("Box");
    const BoxV2 = await ethers.getContractFactory("BoxV2");

    const instance = await upgrades.deployProxy(Box, [42]);
    const upgraded = await upgrades.upgradeProxy(instance.address, BoxV2);

    const value = await upgraded.value();
    expect(value.toString()).to.equal('42');
  });
});
```

#### Truffle plugin
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

#### Multiple inheritance
> Initializer functions are not linearized by the compiler like constructors. Because of this, each __{ContractName}_init function embeds the linearized calls to all parent initializers. As a consequence, calling two of these init functions can potentially initialize the same contract twice.

> The function __{ContractName}_init_unchained found in every contract is the initializer function minus the calls to parent initializers, and can be used to avoid the double initialization problem, but doing this manually is not recommended. We hope to be able to implement safety checks for this in future versions of the Upgrades Plugins.

#### Storage gaps
> You may notice that every contract includes a state variable named __gap. This is empty reserved space in storage that is put in place in Upgradeable contracts. It allows us to freely add new state variables in the future without compromising the storage compatibility with existing deployments.

> It isn’t safe to simply add a state variable because it "shifts down" all of the state variables below in the inheritance chain. This makes the storage layouts incompatible, as explained in Writing Upgradeable Contracts. The size of the __gap array is calculated so that the amount of storage used by a contract always adds up to the same number (in this case 50 storage slots).

### Upgrades plugins

### Proxy pattern
> The plugins support the UUPS, transparent, and beacon proxy patterns. UUPS and transparent proxies are upgraded individually, whereas any number of beacon proxies can be upgraded atomically at the same time by upgrading the beacon that they point to. For more details on the different proxy patterns available, see the documentation for Proxies.

> For UUPS and transparent proxies, use deployProxy and upgradeProxy as shown above. For beacon proxies, use deployBeacon, deployBeaconProxy, and upgradeBeacon. See the documentation for Hardhat Upgrades and Truffle Upgrades for examples.

## Reference
- [OpenZeppelin docs](https://docs.openzeppelin.com/)
- [OpenZeppelin docs : upgradable smart contract](https://docs.openzeppelin.com/learn/upgrading-smart-contracts#whats-in-an-upgrade)