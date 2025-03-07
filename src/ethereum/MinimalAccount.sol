// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { IAccount } from "lib/account-abstraction/contracts/interfaces/IAccount.sol";
import { PackedUserOperation } from "lib/account-abstraction/contracts/interfaces/PackedUserOperation.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol"; 

contract MinimalAccount is IAccount, Ownable {

    constructor () Ownable(msg.sender){}

    // entrypoint -> this contract
    // A signature is valid if it is the MinimalAccount owner!

    function validateUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash, uint256 missingAccountFunds) external returns(uint256 validationData) {

    } {

        _validateSignature(userOp, userOpHash);

    }


}