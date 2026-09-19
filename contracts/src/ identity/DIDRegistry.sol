// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title DIDRegistry
 * @dev Registro de Identidades Descentralizadas (DIDs) en cadena.
 * 
 * Este contrato permite vincular un identificador único (DID) con una dirección Ethereum 
 * y el hash del documento de identidad (DID Document) almacenado off-chain.
 * 
 * Este componente soporta el modelo de privacidad "Privacy by Design" descrito en el Capítulo 11,
 * permitiendo verificar credenciales sin exponer datos personales en la blockchain.
 * 
 * Basado en estándares W3C DID.
 */
contract DIDRegistry {

    // Mapping del DID string -> Direccion del propietario (Controller)
    mapping(string => address) public didOwner;
    
    // Mapping del DID string -> Hash del documento DID (IPFS/Arweave)
    mapping(string => string) public didDocumentHash;

    // Mapping de la direccion -> DID string (Para lookup inverso rápido)
    mapping(address => string) public addressToDid;

    address public admin;
    
    event DIDRegistered(string indexed did, address indexed owner, string documentHash);
    event DIDDocumentUpdated(string indexed did, string newHash);
    event DIDTransferred(string indexed did, address indexed oldOwner, address indexed newOwner);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Solo administrador");
        _;
    }

    /**
     * @dev Establece la identidad del emisor de DIDs (ej. BrickHome KYC Provider).
     * En un entorno real, esto podría ser un Multisig DAO.
     */
    constructor() {
        admin = msg.sender;
    }

    /**
     * @dev Registra un nuevo DID en el registro.
     * Esta función es llamada por el proveedor de identidad tras verificar al usuario off-chain.
     * 
     * @param _did El identificador completo (ej. "did:ethr:0x123...").
     * @param _owner La dirección Ethereum que controla este DID.
     * @param _docHash El hash del documento JSON-LD off-chain que contiene las credenciales.
     */
    function registerDID(
        string memory _did, 
        address _owner, 
        string memory _docHash
    ) external onlyAdmin {
        require(_owner != address(0), "Propietario invalido");
        require(bytes(didOwner[_did]).length == 0, "DID ya registrado");

        didOwner[_did] = _owner;
        didDocumentHash[_did] = _docHash;
        addressToDid[_owner] = _did;

        emit DIDRegistered(_did, _owner, _docHash);
    }

    /**
     * @dev Actualiza el hash del documento asociado al DID.
     * Útil si se añaden nuevas credenciales (ej. cambio de residencia, acreditación nueva).
     * Solo puede ser llamado por el propietario del DID.
     */
    function updateDocument(string memory _did, string memory _newHash) external {
        require(didOwner[_did] == msg.sender, "No eres el propietario del DID");
        
        didDocumentHash[_did] = _newHash;
        emit DIDDocumentUpdated(_did, _newHash);
    }

    /**
     * @dev Permite cambiar la dirección controladora del DID (en caso de pérdida de clave o rotación).
     */
    function transferOwnership(string memory _did, address _newOwner) external {
        require(didOwner[_did] == msg.sender, "No eres el propietario del DID");
        require(_newOwner != address(0), "Nuevo propietario invalido");

        address oldOwner = didOwner[_did];
        didOwner[_did] = _newOwner;
        
        // Actualizar mapping inverso
        addressToDid[_newOwner] = _did;
        
        emit DIDTransferred(_did, oldOwner, _newOwner);
    }

    /**
     * @dev Verifica que una dirección es la controladora de un DID y devuelve el hash del documento.
     * Función de consulta pública para aplicaciones (dApps).
     */
    function resolveDID(string memory _did) external view returns (address, string memory) {
        address owner = didOwner[_did];
        require(owner != address(0), "DID no encontrado");
        return (owner, didDocumentHash[_did]);
    }
}
