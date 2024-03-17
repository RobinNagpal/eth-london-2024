//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;


import {OAppSender, MessagingFee } from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/OAppSender.sol";
import { OAppCore } from "@layerzerolabs/lz-evm-oapp-v2/contracts/oapp/OAppCore.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";


contract LZeroIncreaseSupplyCaps is OAppSender {


    uint256 public constant MAX_SUPPLY = 1000000000 * 10**18;



    constructor(address _endpoint, address _owner) OAppCore(_endpoint, _owner) Ownable(msg.sender) {}

    // call governor bravo to increase the supply cap
    function increaseSupplyCap(address peer) public {
        bytes memory ZERO_BYTES =  bytes("");
        address[] memory targets = new address[](1);
        targets[0] = 0x5A16552f59ea34E44ec81E58b3817833E9fD5436;

        uint256[] memory values = new uint256[](1);
        values[0] = 0; // No ETH sent

        string[] memory signatures = new string[](1);
        signatures[0] = "setSupplyCap(uint256)";

        bytes[] memory calldatas = new bytes[](1);
        uint256 newCap = 2000 * 10**18; // 2000 tokens, assuming 18 decimals
        calldatas[0] = abi.encode(newCap);

        string memory description = "Proposal to increase supply cap to 2 billion.";

        // bytes of array which includes targets, values, signatures, calldatas, and description

        bytes memory encoded = abi.encode(targets, values, signatures, calldatas, description);

        // decoded array
//        (address[] memory decodedTargets, uint256[] memory decodedValues, string[] memory decodedSignatures, bytes[] memory decodedCalldatas, string memory decodedDescription) = abi.decode(encoded, (address[], uint256[], string[], bytes[], string));

        _lzSend(
            11155111,
            abi.encode(encoded),
            ZERO_BYTES,
            // Fee in native gas and ZRO token.
            MessagingFee(0, 0),
            // Refund address in case of failed source message.
            payable(msg.sender)
        );
    }

    function addressToBytes32(address addr) public pure returns (bytes32) {
        return bytes32(uint256(uint160(addr)));
    }

    function updatePeers(address peer) public {
       setPeer(11155111, addressToBytes32(peer));
    }

}
