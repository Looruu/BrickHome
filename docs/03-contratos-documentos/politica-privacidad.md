# Política de Privacidad y Protección de Datos Personales  
**Responsable del Tratamiento:** BrickHome SPV S.A. de C.V.  
**Domicilio:** República de El Salvador  
**Última Actualización:** Julio 2026  
**Versión:** 1.0  

---

## 1. Compromiso con la Privacidad

BrickHome SPV S.A. de C.V. (en adelante, “el Responsable”) se compromete a cumplir con:

- El **Reglamento General de Protección de Datos (RGPD)** de la Unión Europea.  
- La **Ley de Protección de Datos Personales de El Salvador**.

BrickHome implementa un modelo de **Privacidad por Diseño (Privacy by Design)**, minimizando la exposición de datos personales mediante tecnologías avanzadas:

- **Identidades Descentralizadas (DIDs)**  
- **Pruebas de Conocimiento Cero (ZKPs)**  

---

## 2. Datos Recopilados y Clasificación

El ecosistema BrickHome gestiona dos categorías de datos:

---

### A. Datos de Identificación Personal (Off-Chain)

Requeridos para procesos **KYC/AML** necesarios para adquirir el token **BHT-ELZ1**:

- Documento de identidad (DNI, Pasaporte)  
- Prueba de domicilio  
- Número de identificación fiscal  
- Información sobre origen de fondos  

**Almacenamiento:**  
Estos datos **NO** se almacenan en la blockchain pública.  
Se custodian en bases de datos cifradas con **AES-256**, gestionadas por proveedores certificados.

---

### B. Datos de Transacción (On-Chain)

Datos públicos generados en la red blockchain (Ethereum Layer 2):

- Dirección de la billetera (Wallet Address)  
- Histórico de transferencias  
- Balances de tokens  

**Almacenamiento:**  
Por la naturaleza inmutable de la blockchain, estos datos son **públicos y permanentes**.

---

## 3. Tecnologías de Privacidad: DIDs y ZKPs

### 3.1 Identidades Descentralizadas (DIDs)

En lugar de vincular datos personales directamente a una wallet, BrickHome utiliza **DIDs (estándar W3C)**:

- El usuario genera un identificador único:  
  `did:ethr:0x...`
- El contrato `DIDRegistry.sol` vincula el DID a la wallet.  
- El sistema verifica el DID **sin almacenar documentos personales en la blockchain**.

---

### 3.2 Pruebas de Conocimiento Cero (ZKPs)

Utilizadas para validaciones regulatorias sin exponer datos sensibles.

**Funcionamiento:**

- El usuario genera una prueba criptográfica que demuestra una afirmación sin revelar los datos subyacentes.

**Ejemplo:**

Un inversor puede demostrar que:

- Es mayor de 18 años  
- Es residente en un país OCDE  

**Sin revelar:**

- Fecha de nacimiento  
- Dirección exacta  

**Resultado:**  
El contrato inteligente aprueba la transacción basándose únicamente en la validez de la prueba ZKP.

---

## 4. Derechos del Usuario (RGPD)

El usuario, como titular de los datos personales **off-chain**, tiene derecho a:

- **Acceso (Art. 15):** Obtener copia de los datos personales.  
- **Rectificación (Art. 16):** Corregir datos inexactos.  
- **Supresión / Derecho al Olvido (Art. 17):** Eliminar datos personales de los servidores del Responsable.  
- **Limitación On-Chain:**  
  No es posible borrar transacciones de la blockchain.  
  Sin embargo, se puede:  
  - Revocar el DID  
  - Desvincular la wallet del sistema KYC  
  - Impedir futuras transferencias  
- **Portabilidad (Art. 20):** Recibir los datos en formato estructurado.  
- **Oposición (Art. 21):** Oponerse al tratamiento en ciertos casos.



---

## 5. Retención de Datos

- **Datos KYC:**  
  Se retendrán durante el período mínimo exigido por normativa AML (aprox. 5 años tras el cierre de la relación comercial).

- **Datos On-Chain:**  
  Permanentes e inmutables por diseño de la tecnología blockchain.

---

## 6. Seguridad de los Datos

El Responsable implementa medidas técnicas y organizativas avanzadas:

- **Cifrado AES-256:**  
  Para todos los datos personales off-chain.

- **Infraestructura PKI:**  
  Garantiza integridad y autenticidad en comunicaciones internas y firma de documentos.

- **Hardware Security Modules (HSM):**  
  Las claves criptográficas se gestionan en hardware dedicado, evitando extracción de claves privadas.

- **Control de Acceso:**  
  Principio de mínimos privilegios.  
  Solo personal autorizado puede acceder a datos KYC.

---

## 7. Transferencias Internacionales

Los datos pueden ser transferidos a proveedores tecnológicos ubicados fuera de El Salvador (ej. nodos RPC en EE.UU. o Europa).

Estas transferencias se realizan bajo:

- **Cláusulas Contractuales Tipo (SCC)** aprobadas por la Comisión Europea.  

---

### 📅 Última actualización: Julio 2026
