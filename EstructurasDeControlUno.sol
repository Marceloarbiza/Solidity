// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ControlStructures {
    function checkEven(uint256 _number) public pure returns (bool) {
        if (_number % 2 == 0) {
            return true;
        } else {
            return false;
        }
    }

    function sum(uint256 _n) public pure returns (uint256) {
        uint256 total = 0;
        for (uint256 i = 0; i <= _n; i++) {
            total += i;
        }
        return total;
    }
}
