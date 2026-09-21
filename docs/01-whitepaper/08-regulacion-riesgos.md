#  8. Marco Regulatorio y Gestión de Riesgos

## 8.1 Contexto Normativo y Estrategia de Cumplimiento

La tokenización de activos del mundo real (RWA), especialmente en el sector inmobiliario, opera en la intersección de dos marcos legales complejos:

- Legislación de valores tradicional (off‑chain)  
- Normativa emergente sobre criptoactivos (on‑chain)

El desafío central es la fricción entre **derecho off‑chain** y **ejecución on‑chain**.

BrickHome RWA adopta el principio de **Cumplimiento por Diseño (Compliance by Design)**:

- Las restricciones regulatorias **no son controles posteriores**.  
- Son **condiciones de ejecución intrínsecas** al contrato inteligente.  
- Si la ley exige que solo inversores verificados puedan transferir un Security Token, el contrato **revierte automáticamente** la transacción si la condición no se cumple.

### Jurisdicciones Analizadas

- **Unión Europea:** residencia de promotores e inversores potenciales.  
- **El Salvador:** ubicación del activo físico y estructura del SPV.

---

## 8.2 Regulación en la Unión Europea (MiCA y MiFID II)

### 8.2.1 Clasificación de los Activos

El proyecto debe determinar si sus tokens son “Criptoactivos” o “Instrumentos Financieros”.

#### 🔹 Token de Utilidad (RLB)

- Clasificado como **criptoactivo de utilidad**.  
- Exento de regulación de valores **si no otorga derechos financieros** ni expectativas de ganancia.

#### 🔹 Token de Seguridad (BHT‑ELZ1)

- Representa **derechos contractuales sobre flujos de caja futuros** del SPV.  
- Naturaleza financiera híbrida.  
- Clasificado como **instrumento financiero sujeto a MiFID II**.  
- Requiere **prospecto aprobado por la CNMV** (o autoridad competente).

---

### 8.2.2 Requisitos de Prospecto

La emisión del token BHT‑ELZ1 requiere un prospecto que incluya:

- Descripción y valuación del activo subyacente.  
- Derechos de los inversores.  
- Riesgos tecnológicos y de mercado.  
- Estructura del SPV y posibles conflictos de interés.

---

## 8.3 Regulación en El Salvador (CNAD)

El Salvador ha implementado un marco pro‑innovación mediante la **Ley de Emisión de Activos Digitales**, supervisada por la CNAD.

### 8.3.1 Ventajas de la Jurisdicción

- **Claridad Legal:** reconocimiento explícito de activos digitales como medio de pago y titularidad de derechos.  
- **Sandbox Regulatorio:** permite desplegar pilotos bajo supervisión adaptativa.  
- **Fiscalidad:** incentivos fiscales para emisiones de activos digitales.

### 8.3.2 Obligaciones del Emisor

El SPV deberá:

- Registrarse como **proveedor de servicios de activos digitales**, o  
- Asociarse con un **custodio autorizado por la CNAD**.

Esto garantiza que la conversión de rentas (Fiat → Stablecoins) cumpla con normativas AML locales.

---

## 8.4 Matriz de Riesgos y Mitigación Institucional

Evaluación de riesgos críticos y medidas de mitigación según el “Institucional Blueprint”.

| Categoría de Riesgo | Descripción | Probabilidad | Impacto | Medidas de Mitigación |
|---------------------|-------------|--------------|---------|------------------------|
| Regulatorio / Legal | Cambio normativo (MiCA) que reclasifique el token o restrinja su transferencia. | Media | Crítico | Asesoría legal continua; contratos modulares (Proxy Pattern). |
| Tecnológico / Gobernanza | Modificación maliciosa de contratos (Lazarus) o error en Timelock/Multisig. | Baja | Crítico | Multisig Gnosis Safe 3/5; Timelock 48h; PKI y HSM. |
| Tecnológico / Smart Contract | Vulnerabilidad en lógica ERC‑3643 que permita drenaje de fondos. | Baja | Crítico | Auditorías externas (CertiK); seguros de protocolo. |
| Mercado / Liquidez | Imposibilidad de vender el token en mercado secundario. | Alta | Medio | Mercado secundario OTC regulado; acuerdos con Market Makers. |
| Operativo / SPV | Impagos o daños al inmueble que reduzcan el flujo de caja. | Media | Medio | Seguros de impago; fondo CAPEX; diversificación de uso. |
| Oracle / Datos | Inyección de datos falsos por el SPV. | Baja | Alto | Validación multisig; firma PKI de datos off‑chain. |
| Reputacional | Asociación con incidentes de seguridad o fraudes cripto. | Media | Alto | Transparencia radical; cumplimiento ISO 27001. |

---

## 8.5 Gestión de Riesgos de Cumplimiento (KYC/AML)

### 8.5.1 Proceso de Incorporación (Onboarding)

Todo inversor que desee adquirir BHT‑ELZ1 debe superar un proceso KYC/AML:

- Verificación de identidad (DNI/Pasaporte + biometría).  
- Comprobación de origen de fondos.  
- Screening en listas de sanciones (PEP, OFAC).

---

### 8.5.2 Controles On‑Chain (ERC‑3643)

Una vez verificado off‑chain:

- La dirección del inversor se añade a la **Whitelist** del contrato `ComplianceModule.sol`.  
- Las transferencias de BHT‑ELZ1 se rigen por el modificador `onlyCompliant`.  
- Se implementa **Geofencing dinámico** para bloquear jurisdicciones de alto riesgo o sancionadas.

---

### 8.5.3 Protección de Datos (RGPD) y Privacidad por Diseño

El proyecto minimiza el almacenamiento de datos personales en blockchain aplicando el principio de **minimización de datos** del RGPD:

- Datos sensibles se guardan **off‑chain** en bases cifradas (AES‑256).  
- En blockchain se utiliza el estándar **W3C DID** para vincular la wallet a un identificador opaco.  
- Se implementan **Pruebas de Conocimiento Cero (ZKPs)** para validar atributos del inversor sin revelar datos subyacentes.

---

