// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { IAccount } from "lib/account-abstraction/contracts/interfaces/IAccount.sol";
import { PackedUserOperation } from "lib/account-abstraction/contracts/interfaces/PackedUserOperation.sol";
import { Ownable } from "lib/openzeppelin-contracts/contracts/access/Ownable.sol"; 
import { MessageHashUtils } from "lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol";
import { ECDSA } from "lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol";
import { SIG_VALIDATION_FAILED, SIG_VALIDATION_SUCCESS } from "lib/account-abstraction/contracts/core/Helpers.sol"; 
contract MinimalAccount is IAccount, Ownable {

    constructor () Ownable(msg.sender){}

    // entrypoint -> this contract
    // A signature is valid if it is the MinimalAccount owner!

    function validateUserOp(PackedUserOperation calldata userOp, bytes32 userOpHash, uint256 missingAccountFunds) 
        external 
        view
        returns(uint256 validationData) 
    {
        uint256 validationData = _validateSignature(userOp, userOpHash);
        // _validateNonce();
        _payPrefund(missingAccountFunds);

    }
    
    // EIP - 191 version of the signed hash
    function _validateSignature(PackedUserOperation calldata userOp, bytes32 userOpHash)
        internal
        view 
        returns(uint256 validationData)
    {

        bytes32 ethSignedMessageHash = MessageHashUtils.toEthSignedMessageHash(userOpHash);
        address signer = ECDSA.recover(ethSignedMessageHash, userOp.signature);

        if(signer != owner) {
            return SIG_VALIDATION_FAILED;
        }
        return SIG_VALIDATION_SUCCESS;

    }    

    function _payPrefund(uint256 missingAccountFunds) internal {
        if (missingAccountFunds != 0) {
            (bool success, ) = payable(msg.sender).call{value: missingAccountFunds, gas: type(uint256).max}("");
            (success);
        }
    }


}