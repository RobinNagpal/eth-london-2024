//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./IInterchainSecurityModule.sol";

interface ISpecifiesInterchainSecurityModule {
    function interchainSecurityModule()
    external
    view
    returns (IInterchainSecurityModule);
}
