//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./../projects/compound-protocol/contracts/Timelock.sol";

contract MyTimelock is Timelock {
    event Received(address sender, uint amount);

    constructor() Timelock(0x470579d16401a36BF63b1428eaA7189FBdE5Fee9, 3 days) public {
    }

    receive() external payable {
        emit Received(msg.sender, msg.value);
    }

}
