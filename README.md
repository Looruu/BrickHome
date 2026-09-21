# BrickHome RWA: Tokenización Inmobiliaria y Co-living
**License:** MIT  
**Lenguaje:** Solidity

---

##  Presentación del Proyecto

**BrickHome RWA** es un protocolo blockchain aplicado diseñado para resolver fricciones estructurales del mercado inmobiliario:

- Elevada iliquidez  
- Barreras de entrada  
- Opacidad de información  
- Costes de intermediación  

El proyecto plantea la **tokenización de un activo inmobiliario de co-living** ubicado en **Playa El Zonte, El Salvador**, articulado mediante tres pilares fundamentales:

###  1. Sociedad Vehículo de Propósito Especial (SPV)
Entidad legal que ostenta la titularidad del bien raíz y gestiona los flujos de caja *off-chain*.

### 2. Security Token Offering (STO)
Emisión regulada del token **BHT-ELZ1**, el cual representa derechos contractuales sobre los flujos netos distribuibles del SPV.

###  3. Capa de Smart Contracts (Ethereum Layer 2)
Lógica *on-chain* desplegada sobre una red pública de segunda capa para asegurar:

- Transparencia inmutable  
- Eficiencia transaccional  
- Reducción de costes  

La versión **V1.1** incorpora controles institucionales de:

- Ciberseguridad avanzada  
- Privacidad mediante ZKP  
- Resiliencia operativa  

Transformando una idea inicial de hackathon en un **proyecto académico defendible**.

---

## 🎓 Información Académica

### Programa de Estudios
**Máster en Blockchain y Criptoactivos / Criptomonedas**  
IEBS Business School

### Tipo de Proyecto
- **Trabajo Fin de Máster (TFM)**  
- Investigación aplicada con diseño de artefacto y modelo de negocio

### Autores
- **Rubén Acedo**  
- **Xavier Farah**  
- **Nadia Marcela Mira**  
- **Álvaro Arévalo**


**Convocatoria:** 2025/2026

---

##  Estructura del Repositorio

Este repositorio aloja la documentación técnica, legal y académica del TFM.

```text
brickhome-rwa/
├── docs/                         # Documentación completa (GitBook)
│   ├── 01-whitepaper/            # Capítulos del TFM académico
│   ├── 02-presentacion/          # Pitch deck y materiales para inversores
│   ├── 03-contratos-documentos/  # Términos legales, STO y Política de Privacidad
│   └── 04-audits-seguridad/      # Informes de auditoría y ciberseguridad
│
├── contracts/                    # Smart Contracts en Solidity
│   ├── src/
│   │   ├── tokens/               # BHT_ELZ1 (Security), RLB (Utility)
│   │   └── core/                 # ComplianceModule, RentDistributor
│   └── test/                     # Pruebas unitarias
│
├── scripts/                      # Scripts de despliegue (deploy.js)
│
└── frontend/                     # Interfaz de la dApp (Ej. React/Next.js)

````
---

## Características Técnicas

*   **Arquitectura de Doble Token:** Separación entre inversión financiera (BHT-ELZ1) y utilidad comunitaria (RLB).
*   **Cumplimiento Regulatorio:** Integración de módulos KYC/AML nativos en contratos inteligentes.
*   **Seguridad Institucional:** Uso de PKI (Infraestructura de Claves Públicas) y HSM para gestión de claves.
*   **Privacidad:** Implementación de DIDs y Pruebas de Conocimiento Cero (ZKP) para proteger datos de inversores.
*   **Ethereum Layer 2:** Despliegue en red de capa 2 para garantizar escalabilidad y bajos costes de gas.

---

## Documentación

Para profundizar en los aspectos técnicos, financieros y legales del proyecto, consulte los siguientes documentos:

*   [Leer Resumen Ejecutivo](docs/01-whitepaper/00-resumen-ejecutivo.md)
*   [Ver Marco Teórico y RWA](docs/01-whitepaper/02-marco-teorico.md)
*   [Ver Términos de la STO]([docs/03-contratos-documentos/termino-sto.md](https://github.com/Looruu/BrickHome/blob/main/docs/03-contratos-documentos/terminos-sto.md))
*   [Ver Análisis de Seguridad (Lazarus)](docs/04-audits-seguridad/analisis-lazarus.md)

---

## Aviso Legal y Descargo de Responsabilidad

> **IMPORTANTE:** Este repositorio y su contenido constituyen un entregable académico (TFM) y una propuesta de investigación aplicada.
>
> Este documento **NO** constituye una oferta pública de valores, recomendación de inversión ni asesoramiento legal, financiero o de ciberseguridad. Las cifras, modelos financieros y arquitectura técnica son supuestos académicos y requieren un due diligence integral antes de cualquier emisión real.

---

## Licencia

Este proyecto se distribuye bajo la licencia MIT. Consulte el archivo `LICENSE` para más detalles.
