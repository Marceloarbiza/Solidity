// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Vehicle {
    // Variable de estado para almacenar la velocidad del vehículo
    uint public speed;

    // Función para establecer la velocidad del vehículo
    function setSpeed(uint _speed) public {
        speed = _speed;
    }
}

// Contrato para un automóvil que hereda del contrato Vehicle
contract Car is Vehicle {
    // Variable de estado adicional específica para un automóvil
    string public model;

    // Función para establecer el modelo del automóvil
    function setModel(string memory _model) public {
        model = _model;
    }
}