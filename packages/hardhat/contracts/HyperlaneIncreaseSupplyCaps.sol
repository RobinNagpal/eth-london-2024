//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./hyperlane/IMailbox.sol";


contract HyperlaneIncreaseSupplyCaps {


    function increaseSupplyCap(uint256 message_id) public payable {
        bytes memory ZERO_BYTES = new bytes(0);
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


        IMailbox mailbox = IMailbox(0x3C5154a193D6e2955650f9305c8d80c18C814A68);
        bytes32 messageId = mailbox.dispatch{value: msg.value}(
            11155111,
            addressToBytes32(0xFaA578F73C0e7C909FBAf17C530d64200563caFa),
            encoded
        );

    }


    function addressToBytes32(address _addr) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(_addr)));
    }
}
