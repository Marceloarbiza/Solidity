// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAnimal {
    function haceSonido() external view returns (string memory);
    function come() external view returns (string memory);
    function getNombre() external view returns (string memory);
    function getEdad() external view returns (uint256);
}