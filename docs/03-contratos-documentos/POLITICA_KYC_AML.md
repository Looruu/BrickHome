# Política de Cumplimiento Normativo: KYC y Prevención de Lavado de Dinero (AML)

**Entidad Aplicante:** BrickHome SPV S.A. de C.V.  
**Fecha de Entrada en Vigor:** Septiembre 2026  
**Marco Regulatorio de Referencia:**  
- MiCA (Unión Europea)  
- Ley de Emisión de Activos Digitales (El Salvador)  
- Recomendaciones GAFI/FATF  

---

## 1. Objetivo y Alcance

El objetivo de esta política es evitar que la plataforma **BrickHome RWA** y el token **BHT-ELZ1** sean utilizados para:

- Lavado de dinero (ML)  
- Financiación del terrorismo (TF)  
- Evasión fiscal  
- Actividades ilícitas en general  

BrickHome implementa un modelo de **Cumplimiento por Diseño (Compliance by Design)**, donde las restricciones regulatorias están **programadas y ejecutadas automáticamente** a nivel de contrato inteligente, reduciendo la dependencia de la buena fe del usuario.

---

## 2. Procedimiento de Verificación KYC

Para recibir, transferir o interactuar con el token **BHT-ELZ1**, todo usuario debe completar satisfactoriamente el proceso de verificación **off-chain**.

---

### 2.1 Niveles de Verificación

| Nivel | Clasificación | Requisitos Mínimos | Límites de Inversión |
|-------|--------------|--------------------|----------------------|
| **Nivel 1** | Retail Básico | Documento de Identidad + Selfie | Hasta 10,000 USD |
| **Nivel 2** | Retail Avanzado | Nivel 1 + Prueba de Domicilio + Origen de Fondos | Hasta 50,000 USD |
| **Nivel 3** | Acreditado / Institucional | Nivel 2 + Certificación de Acreditación | Sin límite |

---

### 2.2 Flujo del Proceso (Off-Chain → On-Chain)

1. **Envío de Documentación:**  
   El usuario sube sus datos a través de un proveedor certificado (Sumsub, Veriff).

2. **Verificación Automática:**  
   El proveedor realiza comprobaciones de:  
   - Listas de sanciones (PEP, OFAC, listas negras)  
   - Biometría  
   - Autenticidad documental  

3. **Aprobación Manual (Opcional):**  
   En casos de riesgo medio/alto, un Oficial de Cumplimiento revisa el caso.

4. **Whitelisting On-Chain:**  
   Si el usuario es aprobado, el administrador (Multisig) ejecuta:  
