# 10. Plan de Implementación, Roadmap y Métricas

## 10.1 Estrategia de Desarrollo y Fases del Proyecto
El despliegue de BrickHome RWA sigue una metodología iterativa e incremental, adaptando principios ágiles a un entorno de alta regulación financiera.  
El objetivo es mitigar riesgos validando cada componente (legal, técnico, financiero) antes de avanzar a la siguiente fase.

El plan se estructura en un horizonte de **24 meses**, dividido en **cinco fases críticas**.

---

## 10.2 Roadmap 0–24 Meses

### **Fase 1: Concepción y Estructuración (Meses 0–3)**  
**Objetivo:** Sentar las bases legales y conceptuales del proyecto.

- Finalización del TFM y documentación (Whitepaper + Litepaper).  
- Constitución del SPV en El Salvador.  
- Due diligence del inmueble y firma de promesa de compraventa.  
- Arquitectura técnica final (selección de L2, diseño de tokenización).

---

### **Fase 2: Desarrollo y Auditoría Técnica (Meses 4–9)**  
**Objetivo:** Construcción y validación de la infraestructura tecnológica segura.

- Desarrollo de Smart Contracts:  
  BHT‑ELZ1, RLB, ComplianceModule, RentDistributor.  
- Auditoría de seguridad (CertiK, OpenZeppelin).  
- Despliegue en Testnet (Goerli/Sepolia).  
- Integración KYC/AML con proveedores (Sumsub, Identity Labs).

---

### **Fase 3: Pre‑Lanzamiento y Cumplimiento Regulatorio (Meses 10–14)**  
**Objetivo:** Preparación legal y comercial para la STO.

- Registro del prospecto ante CNAD (El Salvador) y notificación en España.  
- Campaña de marketing y whitelisting de inversores cualificados.  
- Token Generation Event (TGE): Venta de BHT‑ELZ1.  
- Cierre de inversión y compra del activo inmobiliario.

---

### **Fase 4: Operación Piloto y Mainnet (Meses 15–20)**  
**Objetivo:** Puesta en marcha del negocio real y distribución de rentas.

- Despliegue en Mainnet (L2 seleccionada).  
- Apertura del co‑living en El Zonte.  
- Primera distribución de rentas (USDC) vía RentDistributor.  
- Activación del marketplace secundario regulado (P2P verificado).

---

### **Fase 5: Escalabilidad y Expansión (Meses 21–24)**  
**Objetivo:** Optimización y preparación para nuevos activos.

- Optimización de precios y ocupación basada en datos reales.  
- Estudio de viabilidad para tokenizar un segundo inmueble.  
- Activación de la DAO para decisiones operativas mediante RLB.

---

## 10.3 Indicadores Clave de Rendimiento (KPIs)

### **KPIs Técnicos y de Seguridad**

| Métrica | Definición | Objetivo |
|--------|------------|----------|
| Gas Promedio por Tx | Coste medio en L2 para transferencias o claim de rentas. | < $0.10 |
| Uptime del Servicio | Disponibilidad de nodos RPC y frontend. | > 99.9% |
| Score de Auditoría | Resultado de auditorías externas. | 0 vulnerabilidades críticas |
| Tiempo de Finalidad | Confirmación de transacciones en L2. | < 2 minutos |

---

### **KPIs Financieros (RWA)**

| Métrica | Definición | Objetivo (Año 1) |
|---------|------------|------------------|
| TVL (Total Value Locked) | Valor total del activo tokenizado on‑chain. | $500,000 USD |
| NOI (Net Operating Income) | Ingresos operativos netos del inmueble. | Positivo y creciente |
| Yield Distribuido | Rentabilidad anual pagada a inversores. | 8% – 10% |
| Occupancy Rate | Ocupación media del co‑living. | > 80% |

---

### **KPIs de Comunidad y Adopción**

| Métrica | Definición | Objetivo |
|---------|------------|----------|
| Wallets Activas | Direcciones únicas con BHT‑ELZ1. | > 100 inversores |
| Tasa de Retención | % de inversores que mantienen el token el primer año. | > 80% |
| Participación en DAO | % de RLB usado en votaciones. | > 30% |

---

## 10.4 Gestión de Riesgos en el Roadmap
El roadmap incorpora **puntos de control (Gates)** entre fases.  
Si un KPI crítico o requisito legal no se cumple (ej. auditoría fallida, prospecto no aprobado), el proyecto se **detiene** para reevaluación antes de liberar fondos para la siguiente fase.

Esta disciplina garantiza que BrickHome RWA no comprometa capital inversor ni reputación avanzando sin fundamentos sólidos.


