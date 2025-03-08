// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import { MinimalAccount } from "src/ethereum/MinimalAccount.sol";
import { DeployMinimal } from "script/DeployMinimal.s.sol";
import { HelperConfig } from "script/HelperConfig.s.sol";

contract  MinimalAccountTest is Test {
    HelperConfig helperConfig;
    MinimalAccount minimalAccount;

    function setup() public {
        DeployMinimal deployMinimal = new DeployMinimal();
        (helperConfig, minimalAccount) = deployMinimal.deployMinimalAccount();

    }

        /*//////////////////////////////////////////////////////////////
                     WHAT DO WE WANT TO ARCHIEVE??
    //////////////////////////////////////////////////////////////*/
    // USDC Approval
    // msg.sender -> MinimalAccount
    // Approve some amount
    // USDC contract
    // come from the entry point

}