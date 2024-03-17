"use client";

import { useReducer } from "react";
import { Abi, AbiFunction } from "abitype";
import type { NextPage } from "next";
import { WriteOnlyFunctionForm } from "~~/app/debug/_components/contract";
import { useDeployedContractInfo } from "~~/hooks/scaffold-eth";
import { GenericContract, InheritedFunctions } from "~~/utils/scaffold-eth/contract";

function InitiazeForm(props: { deployedContractData: GenericContract; fn: AbiFunction }) {
  const { deployedContractData, fn } = props;
  const inheritedFrom = ((deployedContractData as GenericContract)?.inheritedFunctions as InheritedFunctions)?.[
    fn.name
  ];

  const [refreshDisplayVariables, triggerRefreshDisplayVariables] = useReducer(value => !value, false);

  const initialValues = {
    initialize_timelock__address_address: "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512",
    initialize_comp__address_address: "0x5FC8d32690cc91D4c39d9d3abcBD16989F875707",
    initialize_votingPeriod__uint256_uint256: "46523",
    initialize_votingDelay__uint256_uint256: "6646",
    initialize_proposalThreshold__uint256_uint256: "1000",
  };

  return (
    <WriteOnlyFunctionForm
      abi={deployedContractData.abi as Abi}
      key={`initialize`}
      abiFunction={fn}
      onChange={triggerRefreshDisplayVariables}
      contractAddress={deployedContractData.address}
      inheritedFrom={inheritedFrom}
    />
  );
}
const Debug: NextPage = () => {
  const { data: deployedContractData, isLoading: deployedContractLoading } =
    useDeployedContractInfo("IncreaseSupplyCaps");

  const initializeFn =
    deployedContractData &&
    ((deployedContractData.abi as Abi).find(
      part => part.type === "function" && part.name === "initialize",
    ) as AbiFunction);

  return (
    <div className="flex justify-center w-full">
      <div className=" max-w-5xl mt-20 w-full"></div>
    </div>
  );
};

export default Debug;
