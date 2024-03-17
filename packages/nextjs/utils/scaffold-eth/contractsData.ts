import scaffoldConfig from "~~/scaffold.config";
import { contracts } from "~~/utils/scaffold-eth/contract";

export function getAllContracts() {
  const contractsData = contracts?.[scaffoldConfig.targetNetworks[0].id];
  return contractsData ? contractsData : {};
}

export function getAllContractsByChain(chainId: number) {
  const contractsData = contracts?.[chainId];
  return contractsData ? contractsData : {};
}
