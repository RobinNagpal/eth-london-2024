import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const MyGovernorBravoStubModule = buildModule("MyGovernorBravoStubModule", m => {
  const myGovernorBravoStub = m.contract("MyGovernorBravoStub", []);

  return { myGovernorBravoStub };
});

export default MyGovernorBravoStubModule;
