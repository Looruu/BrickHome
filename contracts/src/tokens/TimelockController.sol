// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title TimelockController
 * @dev Contrato que controla la ejecución retardada de operaciones administrativas.
 * 
 * Este contrato es esencial para la gobernanza de BrickHome RWA (Capítulo 11). 
 * Cualquier cambio sensible (ej. actualizar el módulo de compliance, drenar fondos de emergencia)
 * debe ser propuesto, esperar un período de 'minDelay', y luego ejecutado. 
 * Esto permite a la comunidad o a los guardianes detectar y detener actos maliciosos.
 * 
 * Basado en estándares de OpenZeppelin, adaptado para el ecosistema BrickHome.
 */
contract TimelockController {

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant PROPOSER_ROLE = keccak256("PROPOSER_ROLE");
    bytes32 public constant EXECUTOR_ROLE = keccak256("EXECUTOR_ROLE");

    uint256 public minDelay;
    
    address public admin;
    
    // Estructura para almacenar los detalles de la propuesta
    struct Transaction {
        address target;
        uint256 value;
        bytes data;
        bool executed;
        uint256 timestamp;
    }

    // Mapping del ID hash -> Transacción
    mapping(bytes32 => Transaction) public queuedTransactions;

    event QueuedTransaction(bytes32 indexed txId, address indexed target, uint256 value, string signature, bytes data);
    event ExecutedTransaction(bytes32 indexed txId, address indexed target, uint256 value, string signature, bytes data);
    event CancelTransaction(bytes32 indexed txId);
    event MinDelayChange(uint256 oldDelay, uint256 newDelay);

    /**
     * @dev Constructor: Establece el retraso mínimo y el admin inicial.
     * @param _minDelay Segundos de espera mínima (ej. 2 días = 172800 segundos).
     */
    constructor(uint256 _minDelay, address _admin) {
        require(_minDelay >= 1 days, "El retraso minimo debe ser de al menos 1 dia");
        minDelay = _minDelay;
        admin = _admin;
        _setupRole(ADMIN_ROLE, _admin);
    }

    // --- Modificadores de Control de Acceso ---

    modifier onlyRole(bytes32 role) {
        require(hasRole(role, msg.sender), "TimelockController: caller no tiene rol requerido");
        _;
    }

    function hasRole(bytes32 role, address account) public view returns (bool) {
        return (role == ADMIN_ROLE && account == admin);
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "TimelockController: caller no es el admin");
        _;
    }

    // --- Gestión del Tiempo ---

    /**
     * @dev Cambia el retraso mínimo. Requiere el nuevo delay sea mayor al antiguo.
     */
    function updateDelay(uint256 _newDelay) external onlyAdmin {
        require(_newDelay >= minDelay, "El nuevo delay debe ser mayor o igual al actual");
        emit MinDelayChange(minDelay, _newDelay);
        minDelay = _newDelay;
    }

    // --- Propuesta y Ejecución ---

    /**
     * @dev Propone una transacción para su ejecución futura.
     * @param _target Dirección del contrato a llamar.
     * @param _value ETH a enviar.
     * @param _data Data de la llamada (función selector + argumentos).
     */
    function queueTransaction(address _target, uint256 _value, bytes memory _data) external onlyAdmin returns (bytes32) {
        bytes32 txId = getTransactionId(_target, _value, _data, bytes32(0)); // Salt 0 simplificado
        queuedTransactions[txId] = Transaction({
            target: _target,
            value: _value,
            data: _data,
            executed: false,
            timestamp: block.timestamp
        });
        emit QueuedTransaction(txId, _target, _value, "queueTransaction", _data);
        return txId;
    }

    /**
     * @dev Cancela una transacción pendiente.
     */
    function cancelTransaction(bytes32 _txId) external onlyAdmin {
        require(queuedTransactions[_txId].timestamp != 0, "TimelockController: tx no existe");
        require(!queuedTransactions[_txId].executed, "TimelockController: tx ya ejecutada");
        
        delete queuedTransactions[_txId];
        emit CancelTransaction(_txId);
    }

    /**
     * @dev Ejecuta una transacción propuesta una vez pasado el tiempo de espera.
     * @param _target Dirección del contrato.
     * @param _value ETH a enviar.
     * @param _data Data de la llamada.
     */
    function executeTransaction(address _target, uint256 _value, bytes memory _data) external onlyAdmin {
        bytes32 txId = getTransactionId(_target, _value, _data, bytes32(0));
        
        Transaction storage txn = queuedTransactions[txId];
        
        require(txn.timestamp != 0, "TimelockController: tx no encontrada");
        require(!txn.executed, "TimelockController: tx ya ejecutada");
        
        // Verificación del retraso (Timelock)
        require(
            block.timestamp >= txn.timestamp + minDelay,
            "TimelockController: tiempo de espera no cumplido"
        );

        txn.executed = true;
        
        (bool success, ) = _target.call{value: _value}(_data);
        require(success, "TimelockController: ejecucion de tx fallida");
        
        emit ExecutedTransaction(txId, _target, _value, "executeTransaction", _data);
    }

    // --- Helpers ---

    /**
     * @dev Calcula el hash único de la transacción basado en sus parámetros.
     */
    function getTransactionId(
        address _target, 
        uint256 _value, 
        bytes memory _data, 
        bytes32 _salt
    ) public pure returns (bytes32) {
        return keccak256(abi.encode(_target, _value, _data, _salt));
    }

    /**
     * @dev Configuración de roles (Simplificada para el MVP).
     */
    function _setupRole(bytes32 role, address account) internal {
        // En una implementación completa (OpenZeppelin AccessControl), 
        // esto actualizaría mappings de roles. Aquí simplificamos al 'admin'.
        // Para un proyecto real, importar @openzeppelin/contracts/access/AccessControl.sol
    }

    // --- Recibir ETH (Fallback) ---
    // Permite recibir ETH para distribuir, aunque no es necesario para solo llamadas a contratos.
    receive() external payable {}
}
