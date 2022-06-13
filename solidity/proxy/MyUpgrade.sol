// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

/*
 - proxy contract: a contract user will call
 - implementation contract(I1, I2, ...): a contract that will be upgraded

 user ===(invoke function)===> proxy ===(executes a fallback, delegatecall)===> I1
 something bad happens or logic changes, then
 user ===(invoke function)===> proxy ===(delegatecall)===> I2
 only admin ===(invoke upgrade when needed)===> proxy admin ===(invoke upgrade)===> proxy
*/

contract MyUpgrade {

}