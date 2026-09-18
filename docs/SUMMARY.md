# BrickHome RWA: Protocolo de Tokenización Inmobiliaria

---

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.19-blue.svg)](https://soliditylang.org/)

**BrickHome RWA** es una aplicación blockchain de grado institucional diseñada para resolver las fricciones estructurales del mercado inmobiliario (iliquidez, opacidad, barreras de entrada). El proyecto propone la tokenización de un activo de co-living en El Salvador mediante una arquitectura híbrida que integra una Sociedad de Propósito Especial (SPV), una Security Token Offering (STO) y una capa de Smart Contracts sobre Ethereum Layer 2.

Este repositorio contiene la implementación técnica, la documentación académica (TFM), los informes de seguridad y los contratos legales del protocolo.

---

## ⭐ Características Principales

- **Arquitectura de Doble Token:**  
  Separación clara entre el token de seguridad (`BHT-ELZ1`) para derechos económicos y el token de utilidad (`RLB`) para gobernanza y comunidad.

- **Cumplimiento Regulatorio (MiCA):**  
  Integración nativa de módulos KYC/AML y listas blancas (Whitelisting) para garantizar la transparencia y seguridad jurídica.

- **Seguridad Institucional:**  
  Implementación de PKI, Hardware Security Modules (HSM) y mitigaciones contra amenazas avanzadas (Patrón Lazarus).

- **Privacidad por Diseño:**  
  Uso de Identidades Descentralalizadas (DIDs) y Pruebas de Conocimiento Cero (ZKP) para minimizar la exposición de datos personales.

- **Escalabilidad Layer 2:**  
  Despliegue sobre Ethereum Layer 2 (ej. Polygon, Arbitrum) para reducir costes de transacción y mejorar la experiencia del usuario.

---

## 📚 Documentación

La documentación completa del proyecto, incluyendo el Whitepaper, análisis de riesgos y términos legales, está disponible en el directorio `docs/`.

- [Leer Whitepaper Académico](docs/01-whitepaper/00-resumen-ejecutivo.md)
- [Ver Arquitectura y Contratos](docs/01-whitepaper/06-diseno-tecnico.md)
- [Ver Informe de Auditoría de Seguridad](docs/04-audits-seguridad/informe-auditoria.md)
- [Ver Términos de Servicio SPV](docs/03-contratos-documentos/terminos-servicio-spv.md)

---

## 📁 Estructura del Proyecto

```text
brickhome-rwa/
├── contracts/           # Smart Contracts en Solidity
│   ├── src/
│   │   ├── tokens/     # BHT_ELZ1, RLB
│   │   └── core/       # ComplianceModule, RentDistributor
│   └── test/           # Tests unitarios
├── docs/               # Documentación completa (GitBook)
├── scripts/            # Scripts de despliegue (deploy.js)
└── frontend/           # Interfaz de la dApp (React)
