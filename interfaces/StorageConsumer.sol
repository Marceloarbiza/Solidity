// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ISimpleStorage.sol";

contract StorageConsumer {
    ISimpleStorage public simpleStorage;

    constructor(address _simpleStorageAddress) {
        simpleStorage = ISimpleStorage(_simpleStorageAddress);
    }

    function setStorageValue(uint256 x) public {
        simpleStorage.set(x);
    }

    function getStorageValue() public view returns (uint256) {
        return simpleStorage.get();
    }
}
