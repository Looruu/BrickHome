const hre = require("hardhat");
const fs = require("fs");
require("dotenv").config(); // Carga variables de entorno (.env)

async function main() {
  console.log("\n🚀 Iniciando despliegue de BrickHome RWA...");
  console.log("📍 Red:", hre.network.name);

  const [deployer] = await hre.ethers.getSigners();
  console.log("👤 Desplegando con la cuenta:", deployer.address);
  
  // Verificar que la cuenta tiene saldo (Gas Check)
  const balance = await deployer.getBalance();
  console.log("💰 Saldo de la cuenta:", hre.ethers.utils.formatEther(balance), "ETH");
  
  if (balance.eq(0)) {
    throw new Error("❌ ERROR: La cuenta desplegadora no tiene saldo para pagar el gas.");
  }

  // --- CONFIGURACIÓN DINÁMICA ---
  const TOKEN_SUPPLY = hre.ethers.utils.parseUnits("1000000", 18);
  
  // Selección de Stablecoin según la red
  let MOCK_STABLECOIN_ADDRESS;
  if (hre.network.name === "hardhat" || hre.network.name === "localhost") {
    // En local, desplegaremos un mock primero (simplificado aquí para usar una dirección dummy)
    MOCK_STABLECOIN_ADDRESS = "0x0000000000000000000000000000000000000001"; 
    console.log("⚠️ Modo Local/Test detectado. Usando dirección Dummy para Stablecoin.");
  } else {
    // Si es una red pública (Mainnet o Testnet), usar la correcta
    // Sepolia USDC (Ejemplo real) o Mainnet USDC
    MOCK_STABLECOIN_ADDRESS = process.env.STABLECOIN_ADDRESS || "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
    console.log("💲 Stablecoin Objetivo:", MOCK_STABLECOIN_ADDRESS);
  }

  try {
    // --- 1. Despliegue del ComplianceModule ---
    console.log("\n📜 [1/3] Desplegando ComplianceModule...");
    const ComplianceModule = await hre.ethers.getContractFactory("ComplianceModule");
    const complianceModule = await ComplianceModule.deploy();
    await complianceModule.deployed();
    console.log("✅ ComplianceModule desplegado en:", complianceModule.address);

    // --- 2. Despliegue del BHT-ELZ1 ---
    console.log("\n📜 [2/3] Desplegando BHT-ELZ1 (Security Token)...");
    const BHT_ELZ1 = await hre.ethers.getContractFactory("BHT_ELZ1");
    const bhtToken = await BHT_ELZ1.deploy(
      TOKEN_SUPPLY, 
      complianceModule.address
    );
    await bhtToken.deployed();
    console.log("✅ BHT-ELZ1 desplegado en:", bhtToken.address);
    console.log("   Total Supply:", hre.ethers.utils.formatUnits(TOKEN_SUPPLY, 18), "BHT");

    // --- 3. Despliegue del RentDistributor ---
    console.log("\n📜 [3/3] Desplegando RentDistributor...");
    const RentDistributor = await hre.ethers.getContractFactory("RentDistributor");
    const rentDistributor = await RentDistributor.deploy(
      bhtToken.address,
      MOCK_STABLECOIN_ADDRESS 
    );
    await rentDistributor.deployed();
    console.log("✅ RentDistributor desplegado en:", rentDistributor.address);

    // --- 4. Guardar Direcciones ---
    const deploymentData = {
      network: hre.network.name,
      chainId: (await hre.ethers.provider.getNetwork()).chainId.toString(),
      deployer: deployer.address,
      timestamp: new Date().toISOString(),
      contracts: {
        ComplianceModule: complianceModule.address,
        BHT_ELZ1: bhtToken.address,
        RentDistributor: rentDistributor.address,
        Stablecoin: MOCK_STABLECOIN_ADDRESS
      }
    };

    const deploymentsDir = "./deployments";
    if (!fs.existsSync(deploymentsDir)) {
      fs.mkdirSync(deploymentsDir);
    }

    fs.writeFileSync(
      `${deploymentsDir}/${hre.network.name}.json`,
      JSON.stringify(deploymentData, null, 2)
    );
    console.log("\n📝 Archivo de despliegue guardado.");

    // --- 5. Verificación (Solo si no es Hardhat) ---
    if (hre.network.name !== "hardhat" && hre.network.name !== "localhost") {
      console.log("\n🔍 Iniciando verificación en Etherscan...");
      
      // Esperar a que el último contrato (RentDistributor) tenga suficientes confirmaciones
      console.log("⏳ Esperando 5 confirmaciones de bloque...");
      await rentDistributor.deployTransaction.wait(5);
      
      // Función helper para verificar con manejo de errores individual
      const verifyContract = async (address, name, args) => {
        try {
          console.log(`   Verificando ${name}...`);
          await hre.run("verify:verify", {
            address: address,
            constructorArguments: args,
          });
          console.log(`   ✅ ${name} verificado.`);
        } catch (error) {
          console.error(`   ❌ Error verificando ${name}: ${error.message}`);
        }
      };

      await verifyContract(complianceModule.address, "ComplianceModule", []);
      await verifyContract(bhtToken.address, "BHT_ELZ1", [TOKEN_SUPPLY, complianceModule.address]);
      await verifyContract(rentDistributor.address, "RentDistributor", [bhtToken.address, MOCK_STABLECOIN_ADDRESS]);
    }

    console.log("\n🎉 Despliegue finalizado con éxito.");

  } catch (error) {
    console.error("\n💥 CRITICAL ERROR durante el despliegue:");
    console.error(error);
    process.exit(1); // Salir con código de error
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
