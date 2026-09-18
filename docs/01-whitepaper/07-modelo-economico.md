# 7. Modelo Económico-Financiero

## 7.1 Introducción al Modelo
El modelo económico-financiero de BrickHome RWA tiene como objetivo principal demostrar la viabilidad de la inversión a través de un análisis riguroso de los flujos de caja generados por el activo subyacente (inmueble de co-living) y la estructura de costes asociada a la emisión y mantenimiento de los tokens.

El modelo se construye bajo una hipótesis conservadora, priorizando la sostenibilidad operativa sobre la especulación de corto plazo, y utiliza métricas estándar del sector inmobiliario (Cap Rate, NOI, Cash-on-Cash Return) adaptadas al entorno cripto.

---

## 7.2 Estructura de Inversión Inicial (CAPEX)
La inversión inicial requerida para el despliegue del piloto en Playa El Zonte se divide en adquisición del activo físico y puesta en marcha de la infraestructura tecnológica y legal.

### Desglose del Capital Inicial Estimado

| Concepto | Descripción | % del Total |
|----------|-------------|-------------|
| Adquisición del Inmueble | Coste de compra del terreno y/o edificación existente. | 70% |
| Reforma y Acondicionamiento | Adaptación a estándares de co-living (diseño interior, zonas comunes, coworking). | 15% |
| Legal y Constitución SPV | Costes notariales, registro de propiedad y constitución de la entidad vehículo. | 5% |
| Tecnología y Despliegue | Desarrollo de Smart Contracts, auditoría inicial y setup de la infraestructura blockchain. | 5% |
| Reserva de Liquidez | Fondo inicial para cubrir vacíos de ocupación durante los primeros meses. | 5% |

**Total Inversión Estimada:** Variable según mercado local (Referencia académica: $500,000 USD).

---

## 7.3 Proyección de Ingresos y Gastos Operativos (OPEX)
La sostenibilidad del proyecto depende del margen operativo neto (NOI).

### Ingresos Operativos
Basados en el modelo de co-living:

- **Ingresos por Alojamiento:** Tarifa diaria promedio ponderada por tipo de habitación.  
- **Ingresos por Servicios:** Coworking, eventos de comunidad, lavandería.  
- **Tasa de Ocupación:** Estimación conservadora del 80% anual, ajustada por estacionalidad.

### Gastos Operativos
- **Gastos Generales:** Suministros, mantenimiento, seguros, limpieza.  
- **Gastos de Personal:** Gerente on-site, limpieza, soporte comunitario.  
- **Gastos de Plataforma:** Procesamiento de pagos y mantenimiento de la dApp.

---

## 7.4 Distribución de Resultados (Waterfall)
Una vez deducidos los gastos operativos e impuestos, el Flujo de Caja Neto (Net Cash Flow) se distribuye a los tenedores del token **BHT-ELZ1** siguiendo un orden de prelación estricto.

### Cascada de Distribución
1. **Reserva de Mantenimiento (CAPEX):** 5% del NOI destinado a reparaciones mayores.  
2. **Fondo de Administración SPV:** Fee anual para cubrir costes administrativos off-chain.  
3. **Distribución a Inversores:** El remanente se transfiere al contrato **RentDistributor** para reparto proporcional.

**Nota:**  
La distribución es **trimestral y variable**, dependiente exclusivamente de la generación real de caja del activo.

---

## 7.5 Análisis de Sensibilidad y Escenarios

| Escenario | Ocupación Promedio | NOI (Operativo) | Rentabilidad Neta Inversor |
|-----------|---------------------|------------------|-----------------------------|
| Optimista | > 90% | Alto | > 12% anual |
| Base (Esperado) | 80% - 85% | Medio | 8% - 10% anual |
| Pesimista | < 70% | Bajo / Negativo | < 5% anual |

### Conclusiones del Análisis
- El modelo es resistente hasta una ocupación del **65%**, punto en el cual los ingresos solo cubren gastos fijos.  
- El uso de una **Layer 2** es crítico para asegurar que la micro-distribución de rendimientos no sea anulada por los costes de gas.

---

## 7.6 Rentabilidad y Métricas de Retorno (KPIs)
Las métricas clave para monitorizar el éxito económico del proyecto son:

- **Cap Rate (Capitalization Rate):** Relación entre el NOI y el valor del activo.  
- **Cash-on-Cash Return:** Rentabilidad efectiva sobre el efectivo desembolsado por el inversor.  
- **IRR (Tasa Interna de Retorno):** Rentabilidad anualizada proyectada a lo largo de la vida del proyecto (estimado 5 años).

Este modelo financiero validado sirve como base para el Prospecto de la STO y para la configuración de los contratos inteligentes que automatizan el reparto.
