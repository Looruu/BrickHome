# 9. Ciberseguridad, Privacidad y Resiliencia Operativa

---

## 9.1 Modelo de Defensa en Profundidad

BrickHome RWA no es una simple dApp: es una **infraestructura financiera crítica** que gestiona activos reales y fondos fiduciarios.  
Para garantizar su resiliencia, se implementa un modelo de **Defensa en Profundidad (Defense in Depth)**, donde cada capa de seguridad protege a la siguiente.

### Arquitectura de Capas de Seguridad

| Capa | Componente | Controles de Seguridad |
|------|------------|------------------------|
| **1. Red y Nodos** | Infraestructura RPC y nodos validadores | Nodos dedicados, monitoreo de latencia, detección de censura. |
| **2. Smart Contracts** | Contratos en Solidity | Auditorías externas, testing formal, patrones OpenZeppelin (ReentrancyGuard). |
| **3. Identidad y Acceso** | Gestión de claves y firmas | Multisig (Gnosis Safe), HSM, PKI empresarial. |
| **4. Datos** | Almacenamiento off-chain y on-chain | Cifrado AES-256, minimización de datos en blockchain. |
| **5. Operaciones** | Procesos humanos | Entrenamiento anti-phishing, verificación fuera de banda, separación de funciones. |

---

## 9.2 Amenazas Avanzadas: Patrón Lazarus / TraderTraitor

APT como **Lazarus** han adoptado el patrón **TraderTraitor**, documentado por FBI y Chainalysis.

### Vector de Ataque

1. **Compromiso de la cadena de suministro:** Ingeniería social a desarrolladores o personal clave.  
2. **Manipulación del proceso de firma:** Alteración de scripts o solicitudes de firma maliciosas.  
3. **Drenaje de liquidez:** Ejecución de transacciones no autorizadas desde tesorerías.

### Medidas de Mitigación

- **Verificación fuera de banda:** Confirmación de transacciones críticas mediante un canal seguro independiente.  
- **Hardening de entornos de despliegue:** Uso de dispositivos air‑gapped o SO dedicados (Tails, Qubes OS).  
- **Política de privilegios mínimos:** Ninguna clave con permisos unilaterales sobre tesorería.

---

## 9.3 Gestión de Identidad y Claves (IAM y PKI)

La custodia de claves es el núcleo de la seguridad blockchain. BrickHome implementa una **PKI interna** para gestionar certificados y accesos.

### Jerarquía de Custodia

#### Nivel 1: Usuarios Finales (Inversores)
- Wallets estándar (MetaMask, Ledger, Trust Wallet).  
- Recomendación de hardware wallets para grandes posiciones.

#### Nivel 2: Operadores del Protocolo (Team)
- Gnosis Safe multisig (3/5).  
- Distribución de claves entre perfiles técnicos, legales y externos.

#### Nivel 3: Claves de Despliegue (DevOps)
- Custodia en HSM o Fireblocks.  
- Uso exclusivo para despliegues y oráculos.

### Timelock Controller
Todas las funciones administrativas críticas están protegidas por un **Timelock** (ej. 48h), permitiendo detectar y frenar acciones maliciosas antes de su ejecución.

---

## 9.4 Privacidad por Diseño: DIDs y Pruebas de Conocimiento Cero (ZKP)

### Identidad Descentralizada (DID)
En lugar de almacenar datos personales en blockchain:

- El usuario controla su identidad mediante un DID.  
- El protocolo solo valida que el DID ha sido emitido por un proveedor confiable.

### Pruebas de Conocimiento Cero (ZKP)
Permiten demostrar atributos sin revelar datos personales.

Ejemplos:

- “Soy mayor de 18 años.”  
- “Soy inversor acreditado.”  

El contrato valida la prueba sin conocer la identidad del usuario, evitando fugas masivas de datos.

---

## 9.5 Plan de Respuesta a Incidentes

Se asume que un incidente es posible. El plan de respuesta se activa ante cualquier anomalía.

### Procedimiento de Emergencia

1. **Detección:** Alertas automáticas (transacciones anómalas, fallos de nodos).  
2. **Contención:**  
   - Activación de `pause()` en contratos críticos.  
   - Rotación de claves comprometidas.  
3. **Erradicación y Recuperación:**  
   - Auditoría forense.  
   - Migración de fondos a un contrato de emergencia.  
4. **Post‑Incidente:**  
   - Publicación de informe técnico (post‑mortem).  
   - Compensación según políticas del SPV.

---

BrickHome RWA integra estas medidas para elevar el proyecto desde un prototipo académico a una **infraestructura preparada para operar en un entorno financiero hostil y regulado**.
