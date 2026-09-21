# Términos de Servicio y Relación con la SPV  
**Entidad Legal:** BrickHome SPV S.A. de C.V.  
**Domicilio Legal:** República de El Salvador  
**Activo Subyacente:** Inmueble de Co-living en Playa El Zonte, El Salvador  
**Fecha de Entrada en Vigor:** Julio 2026  

---

## 1. Naturaleza de la Relación y Rol del SPV

El SPV actúa como **titular registral** y **gestor operativo** del inmueble físico. Su función es servir como **vehículo de propósito especial**, encapsulando la propiedad del activo y gestionando los flujos de caja *off-chain*, vinculándolos con la lógica *on-chain* mediante smart contracts.

### 1.1 Aislamiento Patrimonial (Bankruptcy Remoteness)

El SPV está diseñado como una entidad independiente cuyo único activo es el inmueble en Playa El Zonte.  
En caso de insolvencia de la empresa matriz o promotores del proyecto:

- El inmueble permanece aislado dentro del SPV.  
- Los flujos de caja continúan protegidos.  
- Los derechos de los tenedores del token **BHT-ELZ1** se mantienen prioritarios.  

### 1.2 No Propiedad Directa

La tenencia de tokens **BHT-ELZ1** o **RLB** **NO otorga**:

- Propiedad del inmueble  
- Copropiedad  
- Derecho a intervenir en la administración diaria del SPV  

La gestión del SPV recae exclusivamente en su **Administrador Único** o **Consejo de Administración**.

---

## 2. Responsabilidades Off-Chain del SPV

El SPV se compromete a gestionar el activo bajo estándares profesionales, incluyendo:

- **Mantenimiento y Conservación:**  
  Mantenimiento preventivo y correctivo para preservar valor y habitabilidad.

- **Cumplimiento Local:**  
  Pago de impuestos prediales, licencias de operación y cumplimiento de normativas turísticas y de seguridad.

- **Gestión de Arrendatarios:**  
  Contratación, cobro de alquileres y resolución de incidencias del co-living.

- **Seguros:**  
  Cobertura de daños al inmueble y responsabilidad civil.

- **Suministros:**  
  Pago de agua, electricidad, internet de alta velocidad y otros servicios esenciales.

---

## 3. Cascada de Pagos (Waterfall) y Distribución

El SPV procesará los ingresos del co-living aplicando el siguiente orden de prelación antes de distribuir rendimientos *on-chain*:

1. **Gastos Operativos:**  
   Mantenimiento, suministros, personal, gestión.

2. **Impuestos y Obligaciones Legales:**  
   Tributos locales y nacionales.

3. **Reserva de Capital (CAPEX):**  
   Reparaciones mayores, estructura, techo, vacancias prolongadas.

4. **Comisión de Gestión del SPV:**  
   Fee administrativo para operación del SPV.

5. **Distribución a Inversores (On-Chain):**  
   El remanente neto (**Distributable Net Cash Flow**) se transfiere al contrato `RentDistributor.sol` para reparto automático.

---

## 4. Interfaz On-Chain: Oráculos y Reporting

El SPV es el **proveedor autorizado de datos off-chain** hacia la blockchain de BrickHome.

### Reporte de Ingresos

El SPV utilizará su clave de administrador (protegida por **Gnosis Safe Multisig**) para ejecutar:

