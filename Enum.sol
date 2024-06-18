// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EnumExample {
    // Declaración del enum
    enum State { Inactive, Active }

    // Variable de estado utilizando el enum
    State public currentState;

    // Constructor
    constructor() {
        // Establecer el estado inicial
        currentState = State.Inactive;
    }

    // Función para activar el estado
    function activate() public {
        currentState = State.Active;
    }

    // Función para desactivar el estado
    function deactivate() public {
        currentState = State.Inactive;
    }
}