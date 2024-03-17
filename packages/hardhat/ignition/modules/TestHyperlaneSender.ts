import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const TestHyperlaneSenderModule = buildModule("TestHyperlaneSenderModule", m => {
  const testHyperlaneSender = m.contract("TestHyperlaneSender", []);

  return { testHyperlaneSender };
});

export default TestHyperlaneSenderModule;
