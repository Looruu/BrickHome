const hre = require("hardhat");
const fs = require("fs");

// Configuración de red
// Para producción, estas direcciones deberían venir de .env o argumentos de línea de comandos
const TOKEN_SUPPLY = hre.ethers.utils.parseUnits("1000000", 18); // 1 Millón de Tokens
const MOCK_STABLECOIN_ADDRESS = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48"; // Ejemplo USDC (Mainnet)

async function main() {
  console.log("\n🚀 Iniciando despliegue de BrickHome RWA...");
  console.log("📍 Red:", hre.network.name);

  const [deployer] = await hre.ethers.getSigners();
  console.log("👤 Desplegando con la cuenta:", deployer.address);
  console.log("💰 Saldo de la cuenta:", (await deployer.getBalance()).toString());

  // --- 1. Despliegue del ComplianceModule (Sin dependencias) ---
  console.log("\n📜 Desplegando ComplianceModule...");
  const ComplianceModule = await hre.ethers.getContractFactory("ComplianceModule");
  const complianceModule = await ComplianceModule.deploy();
  await complianceModule.deployed();
  
  console.log("✅ ComplianceModule desplegado en:", complianceModule.address);

  // --- 2. Despliegue del BHT-ELZ1 (Depende de ComplianceModule) ---
  console.log("\n📜 Desplegando BHT-ELZ1 (Security Token)...");
  const BHT_ELZ1 = await hre.ethers.getContractFactory("BHT_ELZ1");
  
  // Constructor: uint256 _initialSupply, address _complianceAddress
  const bhtToken = await BHT_ELZ1.deploy(
    TOKEN_SUPPLY, 
    complianceModule.address
  );
  await bhtToken.deployed();

  console.log("✅ BHT-ELZ1 desplegado en:", bhtToken.address);
  console.log("   Total Supply:", hre.ethers.utils.formatUnits(TOKEN_SUPPLY, 18), "BHT");
  console.log("   ComplianceModule vinculado:", complianceModule.address);

  // --- 3. Despliegue del RentDistributor (Depende de BHT-ELZ1) ---
  console.log("\n📜 Desplegando RentDistributor...");
  const RentDistributor = await hre.ethers.getContractFactory("RentDistributor");

  // NOTA: Para un test real, necesitas desplegar un MockERC20 antes si no existe en la red.
  // Usamos MOCK_STABLECOIN_ADDRESS como placeholder.
  // Constructor: address _bhtTokenAddress, address _paymentTokenAddress
  const rentDistributor = await RentDistributor.deploy(
    bhtToken.address,
    MOCK_STABLECOIN_ADDRESS 
  );
  await rentDistributor.deployed();

  console.log("✅ RentDistributor desplegado en:", rentDistributor.address);
  console.log("   Token de Pago (Stablecoin):", MOCK_STABLECOIN_ADDRESS);

  // --- 4. Guardar Direcciones en un archivo JSON ---
  const deploymentData = {
    network: hre.network.name,
    chainId: (await hre.ethers.provider.getNetwork()).chainId,
    deployer: deployer.address,
    timestamp: new Date().toISOString(),
    contracts: {
      ComplianceModule: complianceModule.address,
      BHT_ELZ1: bhtToken.address,
      RentDistributor: rentDistributor.address
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

  console.log("\n📝 Archivo de despliegue guardado en:", `${deploymentsDir}/${hre.network.name}.json`);

  // --- 5. Verificación en Etherscan (Opcional, solo si no es localhost) ---
  if (hre.network.name !== "localhost" && hre.network.name !== "hardhat") {
    console.log("\n🔍 Esperando confirmaciones de bloques para verificación...");
    await bhtToken.deployTransaction.wait(5); // Esperar 5 bloques
    
    console.log("⏳ Verificando contratos en Etherscan...");
    try {
      await hre.run("verify:verify", {
        address: complianceModule.address,
        constructorArguments: [],
      });
      await hre.run("verify:verify", {
        address: bhtToken.address,
        constructorArguments: [TOKEN_SUPPLY, complianceModule.address],
      });
      await hre.run("verify:verify", {
        address: rentDistributor.address,
        constructorArguments: [bhtToken.address, MOCK_STABLECOIN_ADDRESS],
      });
      console.log("✅ Verificación completada.");
    } catch (error) {
      console.error("❌ Error en verificación (puede que ya esté verificado):", error.message);
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
