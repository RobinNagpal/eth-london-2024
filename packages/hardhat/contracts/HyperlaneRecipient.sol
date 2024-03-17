// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

interface IGovernorBravo {
    struct Proposal {
        uint id;
        address proposer;
        uint eta;
        uint startBlock;
        uint endBlock;
        uint forVotes;
        uint againstVotes;
        uint abstainVotes;
        bool canceled;
        bool executed;
    }

    function propose(
        address[] memory targets,
        uint256[] memory values,
        string[] memory signatures,
        bytes[] memory calldatas,
        string memory description
    ) external returns (uint256 proposalId);

}

contract HyperlaneRecipient {
    address public governorBravoAddress = 0x9BbE1c9Cbec5147992869424f645988549dE5C35;

    function handle(
        uint32 _origin,
        bytes32 _sender,
        bytes calldata _data
    ) external payable {
        // Decode the incoming data as a string
        (address[] memory decodedTargets, uint256[] memory decodedValues, string[] memory decodedSignatures, bytes[] memory decodedCalldatas, string memory decodedDescription) = abi.decode(_data, (address[], uint256[], string[], bytes[], string));

        IGovernorBravo(governorBravoAddress).propose(decodedTargets, decodedValues, decodedSignatures, decodedCalldatas, decodedDescription);

    }

}
