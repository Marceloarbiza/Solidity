// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IAnimal.sol";

contract Perro is IAnimal {
    string private nombre;
    uint256 private edad;

    constructor(string memory _nombre, uint256 _edad) {
        nombre = _nombre;
        edad = _edad;
    }

    function haceSonido() external pure override returns (string memory) {
        return "Guau";
    }

    function come() external pure override returns (string memory) {
        return "Carne";
    }

    function getNombre() external view override returns (string memory) {
        return nombre;
    }

    function getEdad() external view override returns (uint256) {
        return edad;
    }
}