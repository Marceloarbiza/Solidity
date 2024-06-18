// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventLogging {
    event ValueChanged(address indexed user, uint256 oldValue, uint256 newValue);

    uint256 public value;

    function setValue(uint256 _value) public {
        uint256 oldValue = value;
        value = _value;
        emit ValueChanged(msg.sender, oldValue, value);
    }
}
