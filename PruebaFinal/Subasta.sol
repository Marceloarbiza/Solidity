// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SubastaAvanzada {
    // Direccion del creador del contrato
    address public creador;
    // Valor inicial de la subasta
    uint256 public valorInicial;
    // Fecha de inicio de la subasta
    uint256 public fechaInicio;
    // Duracion de la subasta en segundos
    uint256 public duracion;
    // La mayor oferta actual
    uint256 public mayorOferta;
    // Direccion del ofertante con la mayor oferta
    address public ofertanteGanador;
    // Estado de la subasta (activa o inactiva)
    bool public subastaActiva;
    // Estado de la subasta (finalizada o no finalizada)
    bool public subastaFinalizada;
    // Fecha de finalizacion de la subasta
    uint256 public fechaFinalizacion;

    // Estructura para almacenar ofertas
    struct Oferta {
        uint256 monto; // Monto ofrecido
        bool secreta;  // Indicador si la oferta es secreta
    }

    // Mapeo de direcciones a ofertas
    mapping(address => Oferta) public ofertas;
    // Lista de direcciones de ofertantes
    address[] public ofertantes;

    // Evento para nueva oferta
    event NuevaOferta(address indexed ofertante, uint256 oferta, bool secreta);
    // Evento para subasta finalizada
    event SubastaFinalizada(address ganador, uint256 oferta);

    // Modificador para restringir funciones al creador del contrato
    modifier soloCreador() {
        require(msg.sender == creador, "Solo el creador puede realizar esta accion");
        _;
    }

    // Modificador para verificar que la subasta esta en curso y finalizarla automaticamente si ha terminado
    modifier subastaEnCurso() {
        if (block.timestamp >= fechaFinalizacion && subastaActiva) {
            _finalizarSubasta();
        }
        require(subastaActiva && !subastaFinalizada, "La subasta no esta activa o ya finalizo");
        _;
    }

    // Constructor para inicializar el creador del contrato
    constructor() {
        creador = msg.sender;
    }

    // Funcion para iniciar la subasta
    function iniciarSubasta(uint256 _valorInicial, uint256 _fechaInicio, uint256 _duracion) public soloCreador {
        require(!subastaActiva, "Ya hay una subasta activa");
        valorInicial = _valorInicial;
        fechaInicio = _fechaInicio;
        duracion = _duracion;
        subastaActiva = true;
        subastaFinalizada = false;
        fechaFinalizacion = fechaInicio + duracion;
        mayorOferta = valorInicial;
        ofertanteGanador = address(0);
    }

    // Funcion para ofertar en la subasta
    function ofertar(bool secreta) public payable subastaEnCurso {
        require(block.timestamp >= fechaInicio, "La subasta no ha comenzado");
        // require(msg.value == monto, "El monto enviado no coincide con la oferta");
        require(msg.value > mayorOferta, "La oferta debe ser mayor que la oferta mas alta");

        // Reembolsar oferta anterior si existe
        if (ofertas[msg.sender].monto > 0) {
            payable(msg.sender).transfer(ofertas[msg.sender].monto);
        }

        // Registrar la nueva oferta
        ofertas[msg.sender] = Oferta({
            monto: msg.value,
            secreta: secreta
        });
        ofertantes.push(msg.sender);

        // Actualizar la mayor oferta y el ganador
        mayorOferta = msg.value;
        ofertanteGanador = msg.sender;

        emit NuevaOferta(msg.sender, msg.value, secreta);
    }

    // Funcion para finalizar la subasta
    function finalizarSubasta() public soloCreador subastaEnCurso {
        _finalizarSubasta();
    }

    // Funcion interna para finalizar la subasta
    function _finalizarSubasta() internal {
        require(subastaActiva, "La subasta ya ha finalizado");
        subastaActiva = false;
        subastaFinalizada = true;

        // Transferir el NFT o el artículo ficticio al ganador
        // (Logica de transferencia del NFT no incluida por simplicidad)

        emit SubastaFinalizada(ofertanteGanador, mayorOferta);
    }

    // Funcion para mostrar el ganador de la subasta
    function mostrarGanador() public view returns (address, uint256) {
        require(subastaFinalizada, "La subasta aun no ha finalizado");
        return (ofertanteGanador, mayorOferta);
    }

    // // Funcion para mostrar todas las ofertas realizadas
    // function mostrarOfertas() public view returns (address[] memory, uint256[] memory) {
    //     uint256[] memory montos = new uint256[](ofertantes.length);
    //     for (uint256 i = 0; i < ofertantes.length; i++) {
    //         montos[i] = ofertas[ofertantes[i]].monto;
    //     }
    //     return (ofertantes, montos);
    // }

// Funcion para mostrar todas las ofertas realizadas
function mostrarOfertas() public view returns (address[] memory, uint256[] memory, bool[] memory) {
    // Verificar si el llamante es el creador de la subasta
    bool esCreador = (msg.sender == creador);
    
    // Crear arrays dinamicos en memoria temporal para almacenar las direcciones de los ofertantes, los montos ofrecidos y si las ofertas son secretas
    address[] memory direccionesTemp = new address[](ofertantes.length);
    uint256[] memory montosTemp = new uint256[](ofertantes.length);
    bool[] memory secretasTemp = new bool[](ofertantes.length);
    
    // Recorrer todas las ofertas y filtrar según el rol del llamante
    uint256 contador = 0;
    for (uint256 i = 0; i < ofertantes.length; i++) {
        // Solo mostrar ofertas secretas si el llamante es el creador de la subasta
        if (esCreador || !ofertas[ofertantes[i]].secreta) {
            direccionesTemp[contador] = ofertantes[i];
            montosTemp[contador] = ofertas[ofertantes[i]].monto;
            secretasTemp[contador] = ofertas[ofertantes[i]].secreta;
            contador++;
        }
    }
    
    
    // Crear arrays con el tamano correcto y copiar los elementos desde los arrays temporales
    address[] memory direcciones = new address[](contador);
    uint256[] memory montos = new uint256[](contador);
    bool[] memory secretas = new bool[](contador);
    
    for (uint256 i = 0; i < contador; i++) {
        direcciones[i] = direccionesTemp[i];
        montos[i] = montosTemp[i];
        secretas[i] = secretasTemp[i];
    }
    
    return (direcciones, montos, secretas);
}

// OTRA FORMA DE MOSTRAR

// Función para mostrar todas las ofertas realizadas que no son secretas
    function mostrarOfertasTodas() public view returns (address[] memory, uint256[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < ofertantes.length; i++) {
            if (!ofertas[ofertantes[i]].secreta) {
                count++;
            }
        }
        address[] memory ofertantesNoSecretos = new address[](count);
        uint256[] memory montosNoSecretos = new uint256[](count);
        uint256 currentIndex = 0;
        for (uint256 i = 0; i < ofertantes.length; i++) {
            if (!ofertas[ofertantes[i]].secreta) {
                ofertantesNoSecretos[currentIndex] = ofertantes[i];
                montosNoSecretos[currentIndex] = ofertas[ofertantes[i]].monto;
                currentIndex++;
            }
        }
        return (ofertantesNoSecretos, montosNoSecretos);
    }

    // Función para mostrar todas las ofertas realizadas, incluyendo las secretas si la subasta está finalizada o si el creador del contrato lo solicita
    function mostrarOfertasSecretas() public view returns (address[] memory, uint256[] memory) {
        require(subastaFinalizada || msg.sender == creador, "No tienes permiso para ver las ofertas secretas");
        address[] memory ofertantesTodos = new address[](ofertantes.length);
        uint256[] memory montosTodos = new uint256[](ofertantes.length);
        for (uint256 i = 0; i < ofertantes.length; i++) {
            ofertantesTodos[i] = ofertantes[i];
            montosTodos[i] = ofertas[ofertantes[i]].monto;
        }
        return (ofertantesTodos, montosTodos);
    }

// FIN


    // // Funcion para retirar el deposito
    // function retirarDeposito() public {
    //     require(ofertas[msg.sender].monto > 0, "No tienes deposito para retirar");
    //     require(msg.sender != ofertanteGanador, "El ganador no puede retirar el deposito");

    //     uint256 montoReembolso = ofertas[msg.sender].monto;
    //     ofertas[msg.sender].monto = 0;
    //     uint256 comision = (montoReembolso * 2) / 100;
    //     uint256 reembolso = montoReembolso - comision;

    //     payable(msg.sender).transfer(reembolso);
    // }

    // Funcion para retirar el deposito
function retirarDeposito() public {
    require(ofertas[msg.sender].monto > 0, "No tienes deposito para retirar");
    require(subastaFinalizada, "La subasta aun no ha finalizado");

    uint256 montoReembolso = ofertas[msg.sender].monto;
    ofertas[msg.sender].monto = 0;
    uint256 comision = (montoReembolso * 2) / 100;
    uint256 reembolso = montoReembolso - comision;

    payable(msg.sender).transfer(reembolso);
}

    // Funcion para retirar parcialmente el deposito antes de finalizar la subasta
    function retirarParcial(uint256 porcentaje) public subastaEnCurso {
        require(ofertas[msg.sender].monto > 0, "No tienes deposito para retirar");
        require(porcentaje > 0 && porcentaje <= 100, "El porcentaje debe ser entre 1 y 100");

        uint256 montoParcial = (ofertas[msg.sender].monto * porcentaje) / 100;
        ofertas[msg.sender].monto -= montoParcial;

        payable(msg.sender).transfer(montoParcial);
    }

    function obtenerFechaActual() public view returns (uint256) {
    return block.timestamp;
}
}
