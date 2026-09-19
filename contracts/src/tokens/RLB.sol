// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title RLB
 * @dev Token de Utilidad y Comunidad para el ecosistema BrickHome.
 * 
 * Funciones:
 *  - Gobernanza DAO (Votaciones).
 *  - Acceso prioritario a reservas en co-living.
 *  - Descuentos en servicios.
 * 
 * Este token NO está sujeto a las estrictas restricciones KYC de BHT-ELZ1, 
 * facilitando su adopción pública.
 */
contract RLB is ERC20, Ownable {

    // --- Configuración del Token ---
    string public constant NAME = "BrickHome Loyalty Badge";
    string public constant SYMBOL = "RLB";
    uint8 public constant DECIMALS = 18;

    // Límite de suministro (Cap) para evitar inflación infinita
    uint256 public cap;

    event Minted(address indexed to, uint256 amount);
    event Burned(address indexed from, uint256 amount);

    /**
     * @dev Constructor: Inicia el token con el Cap máximo.
     * El owner (equipo) recibe una reserva inicial (ej. 20% del cap).
     */
    constructor(uint256 _cap) ERC20(NAME, SYMBOL) {
        cap = _cap;
        _mint(msg.sender, _cap / 5); // Reserva inicial del 20%
    }

    /**
     * @dev Mintear nuevos tokens (utilidad o recompensas de comunidad).
     * Requiere que el suministro total no supere el Cap.
     */
    function mint(address _to, uint256 _amount) external onlyOwner {
        require(totalSupply() + _amount <= cap, "Cap exceeded: No se puede emitir más RLB");
        _mint(_to, _amount);
        emit Minted(_to, _amount);
    }

    /**
     * @dev Quemar tokens (Utilizado para actividades de gobernanza).
     */
    function burn(uint256 _amount) external {
        _burn(msg.sender, _amount);
        emit Burned(msg.sender, _amount);
    }
}
