import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const IncreaseSupplyCapsModule = buildModule("IncreaseSupplyCapsModule", m => {
  const increaseSupplyCaps = m.contract("IncreaseSupplyCaps", [
    "0x6edce65403992e310a62460808c4b910d972f10f", // https://docs.layerzero.network/contracts/endpoint-addresses#arbitrum-sepolia-testnet
    "0x35f47c8507D302c4deb675cbdE2b7F9268A35f4A",
  ]);

  return { increaseSupplyCaps };
});

export default IncreaseSupplyCapsModule;
