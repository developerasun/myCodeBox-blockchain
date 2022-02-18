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

## Reference
- [OpenZeppelin docs](https://docs.openzeppelin.com/)