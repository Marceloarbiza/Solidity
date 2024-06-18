// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ISimpleStorage {
    function set(uint256 x) external;
    function get() external view returns (uint256);
}
