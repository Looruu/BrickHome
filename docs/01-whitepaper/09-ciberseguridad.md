# 9. Análisis Regulatorio, Riesgos y Seguridad

## 9.1 Marco Regulatorio
El proyecto opera en la intersección de dos jurisdicciones clave:

### Unión Europea
- Aplicación de **MiCA (Markets in Crypto-Assets)**.  
- Dado el carácter financiero de **BHT‑ELZ1**, también aplica:  
  - **Directiva de Prospecto**  
  - **MiFID II**

### El Salvador
- Aplicación de la **Ley de Emisión de Activos Digitales**.  
- Supervisión por la **CNAD** (Comisión Nacional de Activos Digitales).

### Estrategia de Cumplimiento
Estructurar **BHT‑ELZ1** como un valor extranjero ofertado a inversores cualificados o retail bajo un prospecto registrado, utilizando una **Layer 2** para facilitar la tecnología manteniendo el control regulatorio.

---

## 9.2 Matriz de Riesgos y Mitigación

| Riesgo | Probabilidad | Impacto | Mitigación Propuesta |
|--------|--------------|---------|-----------------------|
| Regulatorio (Prohibición) | Media | Crítico | SPV robusta, asesoría legal continua, adherencia estricta a KYC/AML |
| Tecnológico (Hack/Exploit) | Baja | Crítico | Auditorías de código, Multisig, Timelock, Bug Bounties |
| Mercado (Baja Liquidez) | Alta | Medio | Mercado secundario autorizado, periodos de bloqueo para inversores |
| Operativo (Inquilinos Impagados) | Media | Medio | Seguros de impago, diversificación de inquilinos, reserva de fondos |
| Ciberseguridad (Phishing/Lazarus) | Baja | Alto | PKI empresarial, verificación fuera de banda, formación al equipo |

---

## 9.3 Protección de Datos (RGPD)
Dado que se gestiona información personal (KYC) en Europa:

### Minimización de Datos
Recopilar únicamente la información estrictamente necesaria.

### Uso de ZKP (Zero Knowledge Proofs)
Permite validar que un usuario cumple requisitos (ej. ser mayor de edad, ser acreditado) **sin revelar su identidad** en la blockchain pública.


