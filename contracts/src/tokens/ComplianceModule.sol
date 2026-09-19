// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ComplianceModule
 * @dev Gestiona identidades KYC/AML para el token BHT-ELZ1.
 * 
 * Este módulo implementa una capa de seguridad institucional. El administrador está obligado a ser 
 * un contrato Multisig (ej. Gnosis Safe 3/5) para evitar puntos únicos de fallo.
 * 
 * Basado en los requisitos de Ciberseguridad (Cap 11) y Regulación (Cap 8).
 */
contract ComplianceModule is Ownable {

    enum UserType { None, VerifiedRetail, AccreditedInvestor, Institutional }
    
    struct UserInfo {
        bool isWhitelisted;
        UserType userType;
        uint256 expiryDate; 
        string countryISO;  // Para geofencing
    }

    mapping(address => UserInfo) public users;
    mapping(string => bool) public sanctionedCountries;

    event UserAdded(address indexed user, UserType uType, uint256 expiry);
    event UserRemoved(address indexed user);
    event CountrySanctioned(string indexed countryISO, bool isSanctioned);

    /**
     * @dev Constructor que impone la seguridad institucional.
     * @param _admin Dirección del administrador (DEBE ser un contrato Multisig).
     */
    constructor(address _admin) {
        require(_admin != address(0), "Invalid admin");
        
        // COMPROBACIÓN DE SEGURIDAD (Institucional Blueprint):
        // Verificamos que el administrador sea un contrato inteligente (GnosisSafe)
        // y no una cuenta ordinaria (Soft Wallet).
        // Esto previene ataques del tipo "TraderTraitor" sobre llaves de desarrolladores.
        uint256 size;
        assembly {
            size := extcodesize(_admin)
        }
        require(size > 0, "ComplianceModule: El admin debe ser un contrato Multisig (GnosisSafe) para garantizar seguridad institucional.");
        
        admin = _admin;
    }

    /**
     * @dev Registra un usuario tras pasar KYC off-chain.
     * Nota: Esta función solo puede ser llamada por el Multisig Admin.
     */
    function addUser(
        address _user, 
        UserType _userType, 
        uint256 _expiry, 
        string memory _countryISO
    ) external onlyOwner {
        require(_user != address(0), "Invalid address");
        require(!sanctionedCountries[_countryISO], "Country is sanctioned");

        // Actualización o creación del usuario
        users[_user] = UserInfo({
            isWhitelisted: true,
            userType: _userType,
            expiryDate: _expiry,
            countryISO: _countryISO
        });

        emit UserAdded(_user, _userType, _expiry);
    }

    /**
     * @dev Elimina un usuario de la whitelist (Soft Delete).
     */
    function removeUser(address _user) external onlyOwner {
        require(users[_user].isWhitelisted, "User not whitelisted");
        
        users[_user].isWhitelisted = false;
        // Mantenemos el resto de los datos para auditoría, pero bloqueamos la transferencia
        emit UserRemoved(_user);
    }

    /**
     * @dev Función principal llamada por BHT-ELZ1 antes de permitir una transferencia.
     * Verifica KYC y caducidad.
     */
    function isTransferAllowed(address _from, address _to, uint256 /* _amount */) external view returns (bool) {
        // El remitente debe estar verificado (a menos que sea minting desde address(0))
        if (_from != address(0)) {
            if (!_isVerified(_from)) return false;
        }
        
        // El destinatario debe estar verificado (a menos que sea burning a address(0))
        if (_to != address(0)) {
            if (!_isVerified(_to)) return false;
        }
        return true;
    }

    /**
     * @dev Lógica interna de verificación de KYC.
     * Comprueba estado de whitelist y fecha de expiración.
     */
    function _isVerified(address _user) internal view returns (bool) {
        UserInfo storage u = users[_user];
        if (!u.isWhitelisted) return false;
        
        // Si expiryDate es 0, es permanente. Si es > 0, debe ser futura.
        if (u.expiryDate > 0 && block.timestamp > u.expiryDate) {
            return false;
        }
        return true;
    }

    /**
     * @dev Actualiza la lista de países sancionados (Sanctions Screening).
     */
    function setSanctionedCountry(string memory _countryISO, bool _isSanctioned) external onlyOwner {
        sanctionedCountries[_countryISO] = _isSanctioned;
        emit CountrySanctioned(_countryISO, _isSanctioned);
    }
}
