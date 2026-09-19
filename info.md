## 🚀 Despliegue del Protocolo en Sepolia

Para desplegar los Smart Contracts de BrickHome RWA en la red **Sepolia**, sigue los pasos detallados a continuación.

---

### 1️⃣ Requisitos Previos

Antes de ejecutar el comando de despliegue, asegúrate de:

- Tener instalado **Node.js** (v16+ recomendado).  
- Haber ejecutado previamente `npm install`.  
- Tener configurado un archivo `.env` en la raíz del proyecto con:


> ⚠️ **Importante:**  
> La clave privada **no debe ser** de una wallet personal.  
> Usa una clave custodiada en HSM, Fireblocks o YubiKey según la política de seguridad del proyecto.

---

### 2️⃣ Comando de Despliegue

Ejecuta el siguiente comando para desplegar los contratos en **Sepolia**:

```bash
npx hardhat run scripts/deploy.js --network sepolia
