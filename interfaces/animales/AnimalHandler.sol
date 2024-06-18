// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IAnimal.sol";

contract AnimalHandler {
    IAnimal public animal;

    function setAnimal(address _animalAddress) public {
        animal = IAnimal(_animalAddress);
    }

    function interactuarConAnimal() public view returns (string memory sonido, string memory comer, string memory nombre, uint256 edad) {
        sonido = animal.haceSonido();
        comer = animal.come();
        nombre = animal.getNombre();
        edad = animal.getEdad();
        return (sonido, comer, nombre, edad);
    }
}
