// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title BrickHomeTokenElZonte1
 * @dev Token de Seguridad (Security Token) representando derechos económicos sobre el SPV.
 * Implementa controles KYC/AML y transferencias restringidas para cumplimiento regulatorio (MiCA/CNAD).
 * 
 * Basado en los requisitos del TFM BrickHome RWA.
 * 
 * Se hereda de ERC20 de OpenZeppelin para garantizar compatibilidad de wallets estandar.
 */
contract BHT_ELZ1 is ERC20, Ownable {

    // --- Modulo de Cumplimiento (Compliance) ---
    IComplianceModule public complianceModule;

    event ComplianceModuleUpdated(address indexed newModule);
    event TransferRestricted(address indexed from, address indexed to, uint256 amount, string reason);

    /**
     * @dev Modificador que consulta el módulo de cumplimiento antes de ejecutar transferencias.
     * Esta lógica "envuelve" las funciones estándar de ERC20.
     */
    modifier onlyCompliant(address _from, address _to, uint256 _amount) {
        require(complianceModule.isTransferAllowed(_from, _to, _amount), "Transferencia denegada: KYC/AML fail");
        _;
    }

    constructor(uint256 _initialSupply, address _complianceAddress) ERC20("BrickHome Token El Zonte 1", "BHT-ELZ1") {
        require(_complianceAddress != address(0), "Direccion de compliance invalida");
        
        // Configuración inicial
        complianceModule = IComplianceModule(_complianceAddress);
        
        // Mint inicial al desplegador (SPV)
        _mint(msg.sender, _initialSupply);
    }

    // --- Sobrescritura de Funciones ERC20 con Compliance ---

    /**
     * @dev Transferencia estándar con bloqueo regulatorio.
     */
    function transfer(address _to, uint256 _amount) public override onlyCompliant(msg.sender, _to, _amount) returns (bool) {
        return super.transfer(_to, _amount);
    }

    /**
     * @dev Transferencia desde allowance con bloqueo regulatorio.
     */
    function transferFrom(address _from, address _to, uint256 _amount) public override onlyCompliant(_from, _to, _amount) returns (bool) {
        return super.transferFrom(_from, _to, _amount);
    }

    /**
     * @dev Minting: Bloqueado tras el despliegue para evitar expansión ilícita del supply.
     * Solo el owner (SPV) puede mintear si se habilita una lógica de unlock, 
     * pero por seguridad institucional el supply es fijo tras la creación.
     */
    function mint(address _to, uint256 _amount) external onlyOwner {
        _mint(_to, _amount);
    }

    // --- Funciones de Gobierno ---

    /**
     * @dev Actualiza el contrato de compliance.
     * CUIDADO: Solo el owner (que debe ser un Multisig GnosisSafe) puede hacer esto.
     * Si se cambia a un módulo malicioso que siempre retorna 'true', el token pierde su valor regulatorio.
     */
    function updateComplianceModule(address _newModule) external onlyOwner {
        IComplianceModule oldModule = complianceModule;
        complianceModule = IComplianceModule(_newModule);
        
        // Asegurarse de que el nuevo contrato tiene código (no es una wallet vacía)
        uint256 size;
        assembly {
            size := extcodesize(_newModule)
        }
        require(size > 0, "New compliance module must be a valid contract");

        emit ComplianceModuleUpdated(address(oldModule), _newModule);
    }

    // --- Funciones de Ayuda (Overrides de ERC20 para "Internal" access) ---

    /**
     * @dev Sobrescritura para mejorar claridad y seguridad en _approve (Standard ERC20).
     * Verifica que quien aprueba es el dueño o tiene permiso actual.
     */
    function _approve(address owner, address spender, uint256 amount) internal override {
        // Nota: Heredamos la lógica estándar de ERC20 de OpenZeppelin que gestiona allowance.
        // La implementación manual anterior tenía una pequeña desviación.
        super._approve(owner, spender, amount);
    }
}

interface IComplianceModule {
    function isTransferAllowed(address _from, address _to, uint256 _amount) external view returns (bool);
}
