// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ComplianceModule
 * @dev Gestiona identidades KYC/AML para el token BHT-ELZ1.
 * Implementa whitelist dinámica y geofencing básico.
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
    
    constructor() {}

    /**
     * @dev Registra un usuario tras pasar KYC off-chain.
     */
    function addUser(
        address _user, 
        UserType _userType, 
        uint256 _expiry, 
        string memory _countryISO
    ) external onlyOwner {
        require(_user != address(0), "Invalid address");
        require(!sanctionedCountries[_countryISO], "Country is sanctioned");

        users[_user] = UserInfo({
            isWhitelisted: true,
            userType: _userType,
            expiryDate: _expiry,
            countryISO: _countryISO
        });

        emit UserAdded(_user, _userType, _expiry);
    }

    function removeUser(address _user) external onlyOwner {
        users[_user].isWhitelisted = false;
        emit UserRemoved(_user);
    }

    /**
     * @dev Función principal llamada por BHT-ELZ1 antes de permitir una transferencia.
     */
    function isTransferAllowed(address _from, address _to, uint256 /* _amount */) external view returns (bool) {
        // El remitente debe estar verificado (a menos que sea minting)
        if (_from != address(0)) {
            if (!_isVerified(_from)) return false;
        }
        // El destinatario debe estar verificado
        if (_to != address(0)) {
            if (!_isVerified(_to)) return false;
        }
        return true;
    }

    function _isVerified(address _user) internal view returns (bool) {
        UserInfo storage u = users[_user];
        if (!u.isWhitelisted) return false;
        if (u.expiryDate > 0 && block.timestamp > u.expiryDate) {
            return false;
        }
        return true;
    }

    function setSanctionedCountry(string memory _countryISO, bool _isSanctioned) external onlyOwner {
        sanctionedCountries[_countryISO] = _isSanctioned;
    }
}
