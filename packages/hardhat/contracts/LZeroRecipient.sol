// SPDX-License-Identifier: MIT

pragma solidity ^0.8.22;

import {OAppReceiver, Origin} from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/OAppReceiver.sol";
import {OAppCore} from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/OAppCore.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

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

contract LZeroRecipient is OAppReceiver {

    address public governorBravoAddress = 0x9BbE1c9Cbec5147992869424f645988549dE5C35;

    /// @notice Emitted when a message is received through _lzReceive.
    /// @param senderEid What LayerZero Endpoint sent the message.
    /// @param sender The sending OApp's address.
    event MessageReceived(uint32 senderEid, bytes32 sender);

    /**
     * @notice Initializes the OApp with the source chain's endpoint address.
     * @param _endpoint The endpoint address.
     * @param _owner The OApp child contract owner.
     */
    constructor(address _endpoint, address _owner) OAppCore(_endpoint, _owner) Ownable(msg.sender) {}

    function _lzReceive(
        Origin calldata _origin,
        bytes32,
        bytes calldata payload,
        address,  // Executor address as specified by the OApp.
        bytes calldata  // Any extra data or options to trigger on receipt.
    ) internal override {
        // decoded array
        (address[] memory decodedTargets, uint256[] memory decodedValues, string[] memory decodedSignatures, bytes[] memory decodedCalldatas, string memory decodedDescription) = abi.decode(payload, (address[], uint256[], string[], bytes[], string));

        // Extract the sender's EID from the origin
        uint32 senderEid = _origin.srcEid;
        bytes32 sender = _origin.sender;
        // Emit the event with the decoded message and sender's EID


        emit MessageReceived(senderEid, sender);


        IGovernorBravo(governorBravoAddress).propose(decodedTargets, decodedValues, decodedSignatures, decodedCalldatas, decodedDescription);
    }
}
