# 8. Marco Regulatorio y Gestión de Riesgos

## 8.1 Contexto Normativo y Estrategia de Cumplimiento
La tokenización de activos del mundo real (RWA), especialmente en el sector inmobiliario, opera en la intersección de dos marcos legales complejos: la legislación de valores tradicional y la normativa emergente sobre criptoactivos.

La estrategia de BrickHome RWA se fundamenta en el principio de **Cumplimiento por Diseño (Compliance by Design)**, integrando los controles regulatorios como parte intrínseca de la arquitectura tecnológica y del diseño del token.

Para garantizar la viabilidad legal del proyecto, se ha realizado un análisis comparativo de las jurisdicciones relevantes:

- **Unión Europea:** Donde residen los promotores e inversores potenciales.  
- **El Salvador:** Donde reside el activo físico y se estructura el SPV.

---

## 8.2 Regulación en la Unión Europea (MiCA y MiFID II)

### 8.2.1 Clasificación de los Activos
El proyecto debe determinar si sus tokens son “Criptoactivos” o “Instrumentos Financieros”:

#### **Token de Utilidad (RLB)**
- Clasificado como criptoactivo de utilidad.  
- Exento de regulación de valores mientras no otorgue derechos financieros ni expectativas de ganancia.

#### **Token de Seguridad (BHT‑ELZ1)**
- Representa derechos contractuales sobre flujos de caja futuros del SPV.  
- Posee naturaleza financiera híbrida.  
- Se considera **instrumento financiero** sujeto a **MiFID II**.  
- Requiere prospecto aprobado por la **CNMV** (o autoridad competente).

### 8.2.2 Requisitos de Prospecto
La emisión del token BHT‑ELZ1 requiere un prospecto que incluya:

- Descripción y valuación del activo subyacente.  
- Derechos de los inversores.  
- Riesgos tecnológicos y de mercado.  
- Estructura del SPV y posibles conflictos de interés.

---

## 8.3 Regulación en El Salvador (CNAD)
El Salvador ha implementado un marco pro‑innovación mediante la **Ley de Emisión de Activos Digitales**, supervisada por la **CNAD**.

### 8.3.1 Ventajas de la Jurisdicción
- **Claridad Legal:** Reconocimiento explícito de activos digitales como medio de pago y titularidad de derechos.  
- **Sandbox Regulatorio:** Permite desplegar el piloto bajo supervisión adaptativa.  
- **Fiscalidad:** Incentivos fiscales para emisiones de activos digitales.

### 8.3.2 Obligaciones del Emisor
El SPV deberá:

- Registrarse como proveedor de servicios de activos digitales, **o**  
- Asociarse con un custodio autorizado por la CNAD.  

Esto garantiza que la conversión de rentas (Fiat → Stablecoins) cumpla con normativas AML locales.

---

## 8.4 Matriz de Riesgos y Mitigación

| Categoría de Riesgo | Descripción | Probabilidad | Impacto | Medidas de Mitigación |
|----------------------|-------------|--------------|---------|------------------------|
| Regulatorio / Legal | Cambio normativo (MiCA) que reclasifique el token o restrinja su transferencia. | Media | Crítico | Asesoría legal continua; contratos modulares con proxy patterns. |
| Mercado / Liquidez | Imposibilidad de vender el token en mercado secundario. | Alta | Medio | Mercado secundario interno (OTC); acuerdos con Market Makers. |
| Operativo / SPV | Impagos o daños al inmueble que reduzcan el flujo de caja. | Media | Medio | Seguros de impago; multirriesgo; fondo de reserva CAPEX. |
| Tecnológico / Smart Contract | Vulnerabilidad que permita drenaje de fondos. | Baja | Crítico | Auditorías externas (CertiK, OpenZeppelin); Timelock; seguros de protocolo. |
| Oracle / Datos | Manipulación o fallo en el reporte de ingresos off‑chain. | Baja | Alto | Oráculos redundantes; validación multisig. |
| Reputacional | Asociación con incidentes de seguridad o fraudes cripto. | Media | Alto | Comunicación transparente; estándares ISO 27001. |

---

## 8.5 Gestión de Riesgos de Cumplimiento (KYC/AML)

### 8.5.1 Proceso de Incorporación (Onboarding)
Todo inversor que desee adquirir BHT‑ELZ1 debe superar un proceso KYC/AML:

- Verificación de identidad (DNI/Pasaporte + biometría).  
- Comprobación de origen de fondos.  
- Screening en listas de sanciones (PEP, OFAC).

### 8.5.2 Controles On‑Chain
Una vez verificado off‑chain:

- La dirección del inversor se añade a la **Whitelist** del contrato **ComplianceModule**.  
- Las transferencias de BHT‑ELZ1 solo se permiten entre direcciones verificadas.  
- Se implementa **Geofencing** para bloquear jurisdicciones de alto riesgo.

### 8.5.3 Protección de Datos (RGPD)
El proyecto minimiza el almacenamiento de datos personales en blockchain:

- Los datos sensibles se guardan **off‑chain** en bases cifradas.  
- En la blockchain solo se registra un **hash** o **DID** anónimo.  
- Cumple con el principio de **minimización de datos** del RGPD.

