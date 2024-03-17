"use client";

import { useEffect, useState } from "react";
import { useLocalStorage } from "usehooks-ts";
import { useNetwork } from "wagmi";
import { BarsArrowUpIcon } from "@heroicons/react/20/solid";
import { ContractUI } from "~~/app/debug/_components/contract";
import { useTargetNetwork } from "~~/hooks/scaffold-eth/useTargetNetwork";
import { ContractName } from "~~/utils/scaffold-eth/contract";
import { getAllContracts, getAllContractsByChain } from "~~/utils/scaffold-eth/contractsData";

const selectedContractStorageKey = "scaffoldEth2.selectedContract";
const contractsData = getAllContracts();
const contractNames = Object.keys(contractsData) as ContractName[];

export function DebugContracts() {
  const { chain } = useNetwork();
  const { targetNetwork } = useTargetNetwork();
  const contractsByChain = (chain?.id && getAllContractsByChain(chain?.id)) || {};
  console.log("contractsByChain", contractsByChain);
  const contractNamesByChain = Object.keys(contractsByChain) as ContractName[];

  console.log("chain", chain);
  const [selectedContract, setSelectedContract] = useState(contractNames[0]);

  const contracts = chain?.id ? contractNamesByChain : contractNames;
  const allContractsData = chain?.id ? contractsByChain : contractsData;

  console.log("contracts", contracts);

  console.log("targetNetwork", targetNetwork);
  useEffect(() => {
    setSelectedContract(contracts?.[0]);
  }, [contracts, targetNetwork]);
  return (
    <div className="flex flex-col gap-y-6 lg:gap-y-8 py-8 lg:py-12 justify-center items-center">
      {contracts.length === 0 ? (
        <p className="text-3xl mt-14">No contracts found!</p>
      ) : (
        <>
          {contracts.length > 1 && (
            <div className="flex flex-row gap-2 w-full max-w-7xl pb-1 px-6 lg:px-10 flex-wrap">
              {contracts.map(contractName => (
                <button
                  className={`btn btn-secondary btn-sm font-light hover:border-transparent ${
                    contractName === selectedContract
                      ? "bg-base-300 hover:bg-base-300 no-animation"
                      : "bg-base-100 hover:bg-secondary"
                  }`}
                  key={contractName}
                  onClick={() => setSelectedContract(contractName)}
                >
                  {contractName}
                  {allContractsData[contractName].external && (
                    <span className="tooltip tooltip-top tooltip-accent" data-tip="External contract">
                      <BarsArrowUpIcon className="h-4 w-4 cursor-pointer" />
                    </span>
                  )}
                </button>
              ))}
            </div>
          )}
          {contracts.map(contractName => (
            <ContractUI
              key={contractName}
              contractName={contractName}
              className={contractName === selectedContract ? "" : "hidden"}
            />
          ))}
        </>
      )}
    </div>
  );
}
