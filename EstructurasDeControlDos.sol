// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ControlStructures {
    uint256[] public numbers; // Array dinámico de enteros

    // Añadir un número a la lista
    function addNumber(uint256 _number) public {
        numbers.push(_number);
    }

    // Sumar todos los números en la lista
    function sumNumbers() public view returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < numbers.length; i++) {
            sum += numbers[i];
        }
        return sum;
    }

    // Verificar si un número está en la lista
    function containsNumber(uint256 _number) public view returns (bool) {
        for (uint256 i = 0; i < numbers.length; i++) {
            if (numbers[i] == _number) {
                return true;
            }
        }
        return false;
    }
}
