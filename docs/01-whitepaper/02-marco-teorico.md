# 2. Marco Teórico y Revisión de Literatura Aplicada

## 2.1 DLT, Blockchain y Confianza Programable
Las Tecnologías de Registro Distribuido (DLT) representan un paradigma de arquitectura de software donde la información se comparte, replica y sincroniza entre múltiples nodos independientes, eliminando la necesidad de un servidor central.

La blockchain es una tipología específica donde los datos se agrupan en bloques encadenados criptográficamente. Esto garantiza:

- **Inmutabilidad:** Una vez registrado, el dato no puede ser alterado sin consenso.
- **Trazabilidad:** Auditoría completa del historial de transacciones.

La confianza programable surge de la combinación entre criptografía asimétrica y contratos inteligentes. La confianza se desplaza de las instituciones a reglas criptográficas verificables.

En BrickHome, la blockchain no sustituye al registro de la propiedad, sino que actúa como una capa de eficiencia transaccional y transparencia operativa.

---

## 2.2 Diversificación de Infraestructuras
El análisis del ecosistema debe ir más allá de Ethereum (EVM). Existen arquitecturas alternativas relevantes para RWA:

| Arquitectura | Ejemplo | Ventaja Clave | Desventaja para RWA |
|--------------|---------|---------------|----------------------|
| Solana | Sealevel (Rust) | Velocidad extrema, fees bajos | Menor ecosistema de seguridad institucional |
| Hedera | Hashgraph (HTS) | Compliance nativo en protocolo | Menor descentralización percibida |
| Ethereum L2 | Polygon / Arbitrum | Madurez, liquidez, estándares (ERC‑3643) | Dependencia del puente L1 |

**Decisión de Diseño:**  
BrickHome se orienta inicialmente hacia una **Ethereum Layer 2** por la madurez de sus estándares de seguridad y la profunda liquidez del ecosistema EVM.

---

## 2.3 Tokenización de Activos Reales (RWA)
La tokenización de RWA consiste en la representación digital de derechos sobre un activo físico.  
El desafío no es técnico (emitir un token), sino **garantizar el vínculo jurídico efectivo** entre el token on‑chain y el activo off‑chain.

**Crítica Jurídica:**  
Una afirmación genérica de “propiedad del ladrillo” vía token carece de validez legal en la mayoría de jurisdicciones.

Por ello, la arquitectura de grado institucional exige una **Sociedad de Propósito Especial (SPV)**. En BrickHome:

- La SPV es la titular registral del inmueble en El Zonte.
- El token **BHT‑ELZ1** representa un derecho contractual sobre los flujos netos del SPV, no la propiedad directa del suelo.

---

## 2.4 Security Tokens vs. Utility Tokens
La separación arquitectónica entre ambos es esencial para mitigar riesgos regulatorios.

| Característica | Security Token | Utility Token |
|----------------|----------------|---------------|
| Naturaleza | Instrumento financiero / Inversión | Acceso a servicios / Herramienta |
| Rentabilidad | Expectativa de beneficios o dividendos | Sin promesa de rentabilidad |
| Regulación | MiCA / Ley de Valores / CNAD | Generalmente no regulado como valor |
| Ejemplo BrickHome | BHT‑ELZ1 | RLB |

---

## 2.5 Fragmentación Blockchain (BIS Working Paper No. 1335)
El BIS advierte sobre el riesgo de fragmentación en blockchains públicas.  
Cuando una red se congestiona, los usuarios migran a alternativas más baratas, creando silos de liquidez.

**Implicaciones para BrickHome:**

- **No Multichain Inicial:** El MVP debe arrancar en una única L2 para garantizar profundidad de mercado.
- **Gestión de Tesorería:** La distribución de rentas en stablecoins requiere una política explícita sobre la red de origen, asumiendo que las stablecoins no son plenamente fungibles entre cadenas sin riesgos de puente.

---

## 2.6 Regulación y Cumplimiento
**Unión Europea (MiCA):** Marco regulatorio para criptoactivos. Si el token se considera instrumento financiero, aplica la legislación de valores existente.

**El Salvador (CNAD):** La Comisión Nacional de Activos Digitales supervisa la Ley de Emisión de Activos Digitales.

El diseño de BrickHome integra **cumplimiento por diseño (Compliance by Design)** mediante módulos de identidad (DIDs) y verificación (ZKP).


