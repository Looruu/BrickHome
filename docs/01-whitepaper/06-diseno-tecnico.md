# 6. Diseño Funcional y Arquitectura Tecnológica

## 6.1 Stack Tecnológico Propuesto
Para garantizar escalabilidad, seguridad y bajo coste de transacción, se propone el siguiente stack:

| Capa | Tecnología | Justificación |
|------|------------|---------------|
| Red Base | Ethereum Mainnet (Settlement) | Máxima seguridad final. |
| Ejecución | Ethereum Layer 2 (Polygon / Arbitrum) | Reducción drástica de gas fees para inversores retail. |
| Lenguaje | Solidity ^0.8.19 | Estándar industrial, ecosistema de auditorías maduro. |
| Identidad | ERC‑3643 (T‑REX) / Custom DIDs | Estándar de facto para Security Tokens con KYC on‑chain. |
| Frontend | React.js + Ethers.js / Wagmi | UX moderna y abstracción de wallet. |

---

## 6.2 Arquitectura de Contratos Inteligentes
El sistema consta de cuatro contratos principales:

### 1. **BHT_ELZ1 (Security Token)**
- Hereda de ERC‑20.  
- Incorpora *hooks* de transferencia que consultan al **ComplianceModule**.  
- Solo permite transferencias entre direcciones **whitelisted** (KYC aprobado).

### 2. **RLB (Utility Token)**
- Standard ERC‑20 o ERC‑721 (según decisión final, asumiendo ERC‑20 fungible).  
- Usado para votaciones en Snapshot y pagos de servicios internos.

### 3. **ComplianceModule**
- Gestiona la whitelist de inversores.  
- Permite congelar tokens en caso de requisitos regulatorios (AML).  
- Implementa **geofencing** (bloqueo de transacciones desde países sancionados).

### 4. **RentDistributor**
- Recibe stablecoins (USDC/DAI) procedentes de los ingresos del co‑living.  
- Calcula la proporción de cada inversor según su balance de **BHT_ELZ1** en el momento del snapshot.  
- Permite a los usuarios **claim** (reclamar) sus rendimientos.

---

## 6.3 Seguridad de la Infraestructura
Siguiendo el Blueprint Institucional, la arquitectura incluye:

### **Gnosis Safe (Multisig 3/5)**
Control de las claves administrativas de los contratos.  
Ninguna acción crítica puede ser ejecutada por un solo individuo.

### **Timelock**
Retraso temporal (ej. 48h) entre la propuesta de un cambio (como actualización de contrato) y su ejecución.  
Permite a la comunidad reaccionar ante actos maliciosos.


