# Learning Remix essentials 

> Remix IDE is a powerful open source tool that helps you write Solidity contracts straight from the browser. It is written in JavaScript and supports both usage in the browser, but run locally and in a desktop version.

> Remix IDE has modules for testing, debugging and deploying of smart contracts and much more. 

> Remix-IDE is available at remix.ethereum.org and more information can be found in these docs. Our IDE tool is available at our GitHub repository.

## Unit Testing Plugin

### Customization

> Remix facilitates users with various types of customizations to test a contract properly.

> Solidity Unit Testing refers to the Solidity Compiler plugin for compiler configurations. Configure Compiler, EVM Version, Enable Optimization & runs in the Solidity Compiler plugin and this will be used in the Solidity Unit Testing plugin for contract compilation before running unit tests.

> For interacting with a contract’s method, the prime parameters of a transaction are from address, value & gas. Typically, a method’s behaviour is tested with different values of these parameters.

> One can input custom values for msg.sender & msg.value of transaction using NatSpec comments, like:

```solidity
/// #sender: account-0
/// #value: 10
function checkSenderIs0AndValueis10 () public payable {
    Assert.equal(msg.sender, TestsAccounts.getAccount(0), "wrong sender in checkSenderIs0AndValueis10");
    Assert.equal(msg.value, 10, "wrong value in checkSenderIs0AndValueis10");
}
```

> Instructions to use:

1. Parameters must be defined in the method’s NatSpec
1. Each parameter key should be prefixed with a hash (#) and end with a colon following a space (: ) like #sender: & #value:
1. For now, customization is only available for parameters sender & value
1. Sender is the from address of a transaction which is accessed using msg.sender inside a contract method. It should be defined in a fixed format as ‘account-<account_index>’
1. <account_index> varies from 0-2 before remix-ide release v0.10.0 and 0-9 afterwards
1. remix_accounts.sol must be imported in your test file to use custom sender
1. Value is value sent along with a transaction in wei which is accessed using msg.value inside a contract method. It should be a number.
1. Regarding gas, Remix estimates the required gas for each transaction internally. Still if a contract deployment fails with Out-of-Gas error, it tries to redeploy it by doubling the gas. Deployment failing with double gas will show error:

```
contract deployment failed after trying twice: The contract code couldn't be stored, please check your gas limit
```

> A test contract cannot have a method with parameters. Having one such method will show error: Method 'methodname' can not have parameters inside a test contract

> Number of test accounts are 3 before remix-ide release v0.10.0 and 10 afterwards

> While a test file which imports remix_accounts.sol might not compile successfully with Solidity Compiler plugin, do not worry, this will have no bearing on its success with Solidity Unit Testing plugin.

## Reference

- [Remix - Ethereum IDE](https://remix-ide.readthedocs.io/en/latest/) 