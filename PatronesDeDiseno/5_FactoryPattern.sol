// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contrato hijo que nuestra fábrica producirá
contract ChildContract {
    uint public number;

    // Constructor que inicializa el contrato con un número específico
    constructor(uint _number) {
        number = _number;
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Referencia al contrato hijo
import "./ChildContract.sol";

contract FactoryContract {
    // Array para almacenar las direcciones de los contratos hijos creados
    ChildContract[] public children;

    event ChildCreated(uint number, address childAddress);

    // Función para crear un nuevo contrato hijo
    function createChild(uint _number) public {
        ChildContract child = new ChildContract(_number);
        children.push(child);
        emit ChildCreated(_number, address(child));
    }

    // Función para obtener la dirección de un contrato hijo en el array
    function getChild(uint _index) public view returns (ChildContract) {
        require(_index < children.length, "Indice fuera de limites");
        return children[_index];
    }
}

/*
En este ejemplo, FactoryContract tiene una función createChild que despliega una nueva
instancia de ChildContract con un número específico. Cada nueva instancia de ChildContract
se almacena en el array children, y se emite un evento ChildCreated que registra el número 
asignado y la dirección del nuevo contrato hijo.
*/