import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const HyperlaneRecipientModule = buildModule("HyperlaneRecipientModule", m => {
  const hyperlaneRecipient = m.contract("HyperlaneRecipient", []);

  return { hyperlaneRecipient };
});

export default HyperlaneRecipientModule;
