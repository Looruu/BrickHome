# 5. Caso de Estudio: BrickHome RWA

## 5.1 Selección del Activo: Playa El Zonte, El Salvador
El caso piloto se ubica en **Playa El Zonte, El Salvador**. Esta ubicación responde a una convergencia de factores estratégicos:

### Entorno Regulatorio Pro‑Cripto
El Salvador ha adoptado leyes favorables a la innovación blockchain, incluyendo la **Ley de Emisión de Activos Digitales**, supervisada por la **CNAD**.  
Esto ofrece un marco regulatorio más predecible para pilotos RWA.

### Demografía Objetivo
El Zonte es un hub global para surfistas, nómadas digitales y cripto‑entusiastas, alineando perfectamente con el perfil de usuario objetivo de BrickHome.

### Costes y Potencial
Comparado con mercados maduros de Europa o EE.UU., El Salvador ofrece una **relación calidad‑precio superior** para inmuebles turísticos, permitiendo maximizar el *yield* potencial para los inversores.

---

## 5.2 Modelo Operativo: Co‑living
El inmueble no se gestiona como un alquiler residencial tradicional, sino bajo el modelo de **Co‑living**.

### Mayor Densidad de Renta
Optimización del espacio mediante habitaciones privadas y zonas comunes de alto valor (coworking, eventos, networking).

### Comunidad Activada
Generación de valor añadido a través de servicios (limpieza, eventos, networking) que justifican **primas de precio** sobre el alquiler estándar.

---

## 5.3 Arquitectura de Integración (Off‑Chain a On‑Chain)
Para conectar el inmueble físico con el token digital, se establece el siguiente flujo:

### SPV (Off‑Chain)
- La entidad legal compra o arrienda el inmueble.  
- Gestiona el cobro de los alquileres en co‑living (USD o stablecoins).  
- Paga los gastos operativos (mantenimiento, impuestos, servicios).

### Oráculo / Reporting
Un oráculo —inicialmente **semi‑manual con validadores múltiples**— informa periódicamente a los Smart Contracts sobre los **Ingresos Netos Disponibles**.

### Smart Contracts (On‑Chain)
- El **RentDistributor** recibe los fondos en la blockchain.  
- Los fondos se distribuyen automáticamente a los holders del token **BHT‑ELZ1**.


