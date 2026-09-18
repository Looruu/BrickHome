// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title BrickHomeTokenElZonte1
 * @dev Token de Seguridad (Security Token) representando derechos económicos sobre el SPV.
 * Implementa controles KYC/AML y transferencias restringidas para cumplimiento regulatorio (MiCA/CNAD).
 * 
 * Basado en los requisitos del TFM BrickHome RWA.
 */
contract BHT_ELZ1 {

    // --- Variables de Estado ---

    string public constant NAME = "BrickHome Token El Zonte 1";
    string public constant SYMBOL = "BHT-ELZ1";
    uint8 public constant DECIMALS = 18;
    
    uint256 public totalSupply;
    
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    // --- Modulo de Cumplimiento (Compliance) ---
    IComplianceModule public complianceModule;

    event ComplianceModuleUpdated(address indexed newModule);
    event TransferRestricted(address indexed from, address indexed to, uint256 amount, string reason);

    modifier onlyCompliant(address _from, address _to, uint256 _amount) {
        require(complianceModule.isTransferAllowed(_from, _to, _amount), "Transferencia denegada: KYC/AML fail");
        _;
    }

    constructor(uint256 _initialSupply, address _complianceAddress) {
        require(_complianceAddress != address(0), "Direccion de compliance invalida");
        _balances[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
        complianceModule = IComplianceModule(_complianceAddress);
        emit Transfer(address(0), msg.sender, _initialSupply);
    }

    // --- Funciones de Transferencia con Compliance ---

    function transfer(address _to, uint256 _amount) public onlyCompliant(msg.sender, _to, _amount) returns (bool) {
        _transfer(msg.sender, _to, _amount);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _amount) public onlyCompliant(_from, _to, _amount) returns (bool) {
        uint256 currentAllowance = _allowances[_from][msg.sender];
        require(currentAllowance >= _amount, "ERC20: transfer amount exceeds allowance");

        _approve(_from, msg.sender, currentAllowance - _amount);
        _transfer(_from, _to, _amount);
        return true;
    }

    function _transfer(address _from, address _to, uint256 _amount) internal {
        require(_balances[_from] >= _amount, "ERC20: transfer amount exceeds balance");
        require(_to != address(0), "ERC20: transfer to the zero address");

        _balances[_from] -= _amount;
        _balances[_to] += _amount;
        emit Transfer(_from, _to, _amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    // --- Getters Públicos ---
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }
    
    // --- Gestión Administrativa ---
    function updateComplianceModule(address _newModule) external {
        // En producción, esto debe estar protegido por un Timelock o Multisig
        complianceModule = IComplianceModule(_newModule);
        emit ComplianceModuleUpdated(_newModule);
    }
}

interface IComplianceModule {
    function isTransferAllowed(address _from, address _to, uint256 _amount) external view returns (bool);
}
