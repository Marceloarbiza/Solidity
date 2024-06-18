// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExternalFunctionExample {
    uint256 public value;

    function setValue(uint256 _value) external {
        value = _value;
    }

    function callExternalFunction(uint256 _newValue) public {
        // Llamando a la función `external` desde dentro del contrato
        this.setValue(_newValue);
    }
}
