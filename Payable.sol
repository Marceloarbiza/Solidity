// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EjemploPayable {
    address public owner;
    uint256 public balance;

    // Constructor para establecer el propietario del contrato
    constructor() {
        owner = msg.sender;
    }

    // Función payable para recibir Ether
    function depositar() external payable {
        balance += msg.value;
    }

    // Función para obtener el saldo del contrato
    function obtenerSaldo() public view returns (uint256) {
        return address(this).balance;
    }

    // Función para retirar fondos, solo el propietario puede hacerlo
    function retirar(uint256 cantidad) public {
        require(msg.sender == owner, "Solo el propietario puede retirar fondos");
        require(cantidad <= balance, "Fondos insuficientes");

        payable(msg.sender).transfer(cantidad);
        balance -= cantidad;
    }

    // Función receive para recibir Ether sin datos
    receive() external payable {}

    // Fallback function para recibir Ether con datos
    fallback() external payable {}
}
