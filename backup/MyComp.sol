//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./../projects/compound-protocol/contracts/Governance/Comp.sol";

contract MyComp is Comp {
    constructor(address account) Comp(account)  {
    }
}
