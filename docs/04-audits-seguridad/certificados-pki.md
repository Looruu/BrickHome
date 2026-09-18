# Infraestructura de Claves Públicas (PKI) y Gestión de Claves  
**Propósito del Documento:** Definir la arquitectura de seguridad para la gestión de identidad y firmas digitales en el ecosistema BrickHome RWA.  
**Estándar:** X.509 v3 / RFC 5280

---

## 1. Resumen Ejecutivo
BrickHome RWA implementa una **Infraestructura de Claves Públicas (PKI)** interna de nivel institucional.  
Este sistema garantiza que todas las operaciones críticas —despliegue de contratos, reportes financieros off‑chain, actualizaciones de software— sean firmadas digitalmente por entidades autorizadas, proporcionando:

- **No repudio**  
- **Trazabilidad completa**  
- **Separación de funciones**  
- **Mitigación de riesgos de robo de identidad**

La PKI elimina la dependencia de claves almacenadas en dispositivos personales, reduciendo la superficie de ataque ante amenazas avanzadas como Lazarus/TraderTraitor.

---

## 2. Arquitectura PKI Jerárquica
BrickHome adopta un modelo jerárquico de **tres niveles (Three‑Tier Hierarchy)** para asegurar que la **Root CA** nunca esté expuesta a la red.

### 2.1 Nivel 1: Autoridad Certificadora Raíz (Root CA)
- **Estado:** Offline (fuera de línea).  
- **Almacenamiento:** HSM FIPS 140‑2 Nivel 3 en caja de seguridad física.  
- **Función:** Emite certificados únicamente a las Autoridades Intermedias.  
- **Duración del Certificado:** 20 años.  
- **Restricción:** Nunca firma operaciones diarias.

### 2.2 Nivel 2: Autoridades Intermedias (Intermediate CAs)
- **Estado:** Online en red aislada (Red de Gestión).  
- **Almacenamiento:** HSM en nube o tokens hardware (YubiKey 5Ci).  
- **Función:** Emite certificados a usuarios finales y sistemas.  
- **Tipos:**  
  - **CA de Desarrollo:** Para entornos de Testnet.  
  - **CA de Producción:** Para Mainnet.

### 2.3 Nivel 3: Entidades Finales (End Entities)
- **Titulares:** Desarrolladores, oficiales de cumplimiento, sistemas CI/CD.  
- **Almacenamiento:** Tokens hardware (Nitrokey, YubiKey) o enclaves seguros (AWS KMS, Fireblocks).

---

## 3. Ciclo de Vida de los Certificados

### 3.1 Emisión (Issuance)
1. **CSR:** El usuario genera una solicitud de firma desde su token hardware.  
2. **Verificación:** Identidad validada por el equipo de seguridad (presencial o videollamada).  
3. **Firma:** La CA Intermedia firma el CSR.  
4. **Publicación:** El certificado se añade a la lista de confianza interna.

### 3.2 Rotación y Renovación
- **Renovación Automática:** Alerta 30 días antes de caducidad.  
- **Rotación de Emergencia:** Revocación inmediata en caso de sospecha de brecha.

### 3.3 Revocación
- El certificado se añade a la **CRL (Certificate Revocation List)**.  
- Los sistemas verifican la CRL cada hora.  
- Cualquier operación firmada con un certificado revocado es rechazada.

---

## 4. Casos de Uso en BrickHome RWA

### 4.1 Firmado de Smart Contracts
Los contratos (ej. `BHT-ELZ1.sol`, `ComplianceModule.sol`) deben estar firmados con un certificado PKI válido antes del despliegue.

**Proceso:**
- El compilador (Hardhat) verifica la firma del bytecode.  
- Si falta la firma o el certificado expiró, el despliegue se aborta.  
- Previene la inserción de código malicioso por actores externos.

---

### 4.2 Oráculos y Off‑Chain Data
Cuando el SPV reporta ingresos mensuales:

- El documento (JSON/PDF) es firmado por el CFO.  
- El contrato inteligente verifica la firma contra el certificado registrado.  
- Garantiza integridad y autenticidad del dato.

---

### 4.3 Confianza en el Repositorio (Git)
Todos los commits deben estar firmados (`git commit -S`) con GPG respaldado por un certificado PKI.

Esto garantiza:

- Integridad del código fuente  
- Trazabilidad de cambios  
- Prevención de inserción de código malicioso

---

## 5. Almacenamiento en Módulos de Seguridad de Hardware (HSM)

Se prohíbe almacenar claves privadas en disco (`.pem`, `.keystore`) o variables de entorno.

### Soluciones Aprobadas

| Solución | Caso de Uso | Nivel de Seguridad |
|----------|-------------|--------------------|
| YubiKey 5Ci / Nitrokey | Firmado de commits, autenticación de usuarios | Alto (requiere toque físico) |
| Fireblocks / Fordefi | Custodia de tesorería, despliegue de contratos | Institucional (MPC – Multi‑Party Computation) |
| AWS CloudHSM / Azure Key Vault | Gestión de secretos de oráculos y APIs | Alto (enclave seguro en nube) |

---

## 6. Políticas de Uso y Auditoría

- **Sin Claves Compartidas:** Cada certificado es personal e intransferible.  
- **Auditoría de Firmas:** Cada operación crítica registra el *Serial Number* del certificado utilizado.  
- **Ceremonia de Llaves:** La generación de la Root CA se realizó en una ceremonia presencial con testigos y acta notarial (digital notarization).

---

## 7. Conclusión
La implementación de PKI en BrickHome RWA eleva el proyecto desde un protocolo DeFi estándar a una **Infraestructura Financiera Digital** con identidad verificable en cada operación.

Esto permite:

- Cumplimiento regulatorio (MiCA, auditorías externas).  
- Seguridad institucional contra amenazas avanzadas.  
- Trazabilidad completa de acciones críticas.  
- Eliminación de incertidumbre sobre “quién” firmó cada operación.

La PKI es un pilar esencial para operar en entornos financieros regulados y hostiles, garantizando confianza, integridad y resiliencia.


