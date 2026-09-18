# Análisis de Amenaza: Patrón Lazarus / TraderTraitor  
**Fecha del Informe:** Julio 2026  
**Clasificación:** Confidencial / Uso Interno  
**Autor:** Comité de Ciberseguridad BrickHome

---

## 1. Resumen Ejecutivo
El grupo **Lazarus**, vinculado a la República Popular Democrática de Corea y responsable de ataques graves contra entidades financieras y protocolos cripto, mantiene operaciones activas en el ecosistema blockchain.  
Uno de sus patrones más característicos es **TraderTraitor** (también conocido como BeagleBoyz), un vector de ataque centrado en ingeniería social y compromiso de la cadena de suministro.

Dado que BrickHome RWA gestiona activos financieros reales (RWA) y tesorerías on‑chain, este actor constituye una amenaza relevante.  
El presente informe detalla el vector de ataque y las medidas implementadas para neutralizarlo.

---

## 2. Vector de Ataque: TraderTraitor

A diferencia de atacantes que buscan vulnerabilidades en Solidity, Lazarus se especializa en comprometer **personas, procesos y entornos de desarrollo**.

### 2.1 Metodología (TTPs)

#### Infiltración (Ingeniería Social)
- Suplantación de reclutadores de fondos VC o headhunters en LinkedIn.  
- Envío de ofertas laborales atractivas a desarrolladores senior.  
- Solicitud de ejecutar herramientas o revisar código como parte del “proceso de selección”.

#### Compromiso de Supply Chain
- Los archivos proporcionados contienen **malware tipo RAT** (Remote Access Trojan).  
- Una vez ejecutado, el malware roba credenciales, claves SSH y frases semilla de wallets.

#### Movimiento Lateral y Exfiltración
- Acceso a repositorios privados (GitHub).  
- Robo de claves de API, credenciales de oráculos o wallets de despliegue.  
- Preparación de transacciones maliciosas o modificaciones de contratos.

---

## 3. Impacto Potencial en BrickHome RWA

BrickHome utiliza una arquitectura **Multisig Gnosis Safe 3/5** para la administración de tesorería y despliegue de contratos.

### Escenario de Ataque Simulado

Si Lazarus compromete las cuentas de **3 de los 5 signatarios**:

- **Consenso Malicioso:** Firma coordinada de una transacción para drenar la tesorería (USDC) hacia un mixer o exchange no KYC.  
- **Reemplazo de Contratos:** Modificación del RentDistributor o ComplianceModule para permitir transferencias sin KYC.  
- **Resultado:** Pérdida total de fondos y daño reputacional irreversible.

---

## 4. Estrategia de Mitigación: Defensa en Profundidad

BrickHome implementa contramedidas específicas para neutralizar el patrón Lazarus.

### 4.1 Verificación Fuera de Banda (Out‑of‑Band Verification)

Todas las transacciones críticas del Multisig requieren confirmación por un canal independiente:

**Protocolo:**
1. Un administrador propone la transacción en Gnosis Safe.  
2. Los signatarios reciben notificación automática.  
3. Cada signatario debe confirmar vía llamada o mensaje cifrado (Signal/Telegram) con código de validación.  
4. Si existe discrepancia, la firma se revoca inmediatamente.

---

### 4.2 Hardening de Entornos de Despliegue (Air‑Gapping)

Se prohíbe el uso de laptops personales para firmar transacciones.

**Política de Dispositivos:**
- Laptops dedicadas (“burner”) sin navegación web ni correo personal.  
- Preferencia por sistemas Linux endurecidos (Tails, Qubes OS).  
- Entornos virtualizados aislados para operaciones críticas.

---

### 4.3 Infraestructura de Claves Públicas (PKI) y HSM

Para eliminar el riesgo de robo de claves:

- **HSM (Hardware Security Modules):** Las claves maestras nunca se exportan; residen en hardware seguro (Fireblocks, CloudHSM).  
- **MFA obligatorio:** Firma de transacciones solo con autenticación multifactor.  
- **PKI Empresarial:** Uso de YubiKeys para firmar commits y accesos VPN.

---

### 4.4 Segregación de Privilegios

- **Principio de Mínimo Privilegio:**  
  - Desarrolladores frontend no tienen acceso a claves de despliegue.  
  - Auditores no pueden ejecutar transacciones financieras.

- **Rotación de Claves:**  
  - Rotación cada 90 días de claves de API y accesos a repositorios.  
  - Invalida credenciales comprometidas silenciosamente.

---

## 5. Matriz de Control de Efectividad

| Control | Eficacia contra Phishing | Eficacia contra Malware | Coste Operativo |
|--------|---------------------------|--------------------------|------------------|
| Multisig 3/5 | Medio | Bajo | Bajo |
| Verificación Fuera de Banda | Alto | Alto | Medio |
| Laptops Dedicadas | Bajo | Alto | Alto |
| HSM / Custodia Institucional | Muy Alto | Muy Alto | Medio‑Alto |

---

## 6. Conclusiones y Recomendaciones

El patrón Lazarus constituye una amenaza crítica para cualquier infraestructura que dependa de claves privadas en endpoints personales.  
BrickHome adopta una postura defensiva agresiva combinando:

- **HSMs** → Eliminan la superficie de ataque basada en robo de software.  
- **Verificación Fuera de Banda** → Previene la autorización de transacciones maliciosas incluso si un signatario ha sido comprometido.

### Recomendación Continua
Realizar ejercicios de **Red Teaming** semestrales para evaluar la resistencia del equipo ante ingeniería social avanzada.

