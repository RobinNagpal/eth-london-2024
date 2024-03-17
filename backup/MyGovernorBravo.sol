//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./../projects/compound-protocol/contracts/Governance/GovernorBravoDelegate.sol";

contract MyGovernorBravo is GovernorBravoDelegate {
    constructor() {
        admin = 0x470579d16401a36BF63b1428eaA7189FBdE5Fee9;
    }

    function initialize(address timelock_, address comp_, uint votingPeriod_, uint votingDelay_, uint proposalThreshold_) override virtual public {
        require(address(timelock) == address(0), "GovernorBravo::initialize: can only initialize once");

        timelock = TimelockInterface(timelock_);
        comp = CompInterface(comp_);
        votingPeriod = votingPeriod_;
        votingDelay = votingDelay_;
        proposalThreshold = proposalThreshold_;
    }


}
