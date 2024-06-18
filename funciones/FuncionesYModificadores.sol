// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExampleContract {
    uint256 public value;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Public function
    function setValue(uint256 _value) public {
        value = _value;
    }

    // Internal function
    function _calculate(uint256 _a, uint256 _b) internal pure returns (uint256) {
        return _a + _b;
    }

    // External function
    function externalFunction(uint256 _value) external {
        value = _value;
    }

    // Private function
    function _privateFunction(uint256 _value) private {
        value = _value;
    }

    // View function
    function getValue() public view returns (uint256) {
        return value;
    }

    // Pure function
    function add(uint256 _a, uint256 _b) public pure returns (uint256) {
        return _a + _b;
    }

    // Payable function
    function receivePayment() public payable {
        // Function logic
    }
}
