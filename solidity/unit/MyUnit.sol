// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Understanding Ethereum units
/// @author Jake Sung
/// @notice Units in Ethereum smart contracts
/// @dev Check unit details in Solidity docs
contract MyUnit {
    ///////////////// Currency units /////////////////
    // 1 wei == 1; => the smallest unit in smart contract. The wei only can be sent
    // in transactions.
    // 1 gwei == 1e9; => 1000000000 (nine zeros)
    // 1 ether == 1e18; => 100..000 (eighteen zeros)

    // convert wei(default) to ether in smart contract
    uint256 costOfNFT = 0.01 ether;
    ///////////////// Currency units /////////////////

    //////////////// Time units ////////////////
    // 1 == 1 seconds
    // 1 minutes == 60 seconds
    // 1 hours == 60 minutes
    // 1 days == 24 hours
    // 1 weeks == 7 days
    
    // convert seconds to minutes
    uint8 sixtySec = 1 minutes;
    //////////////// Time units ////////////////

    //////////////// Gas ////////////////
    // higher gas fee, higher your transactions confirmation priority.
    // typically user sets gas (fee) limit. 
    // computing power to confirm the transaction > gas limit => transaction success
    // computing power to confirm the transaction < gas limit => transaction fail
    //////////////// Gas ////////////////
}