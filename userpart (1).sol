// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract StorageContract {

    struct Purchase {
        address addr;
        uint id;
        uint32 quantity;
        address addrto;
        uint paid;
    }

    Purchase[] public purchases;

    event PurchaseStored(address addr, uint id, uint32 quantity, address addrto, uint paid);

    function storePurchase(address addr, uint id, uint32 quantity, address addrto) public payable {
        //require(msg.value > 0, "Must send a non-zero value with the transaction");

        // Store the purchase details
        Purchase memory newPurchase = Purchase({
            addr: addr,
            id: id,
            quantity: quantity,
            addrto: addrto,
            paid: msg.value
        });

        purchases.push(newPurchase);

        emit PurchaseStored(addr, id, quantity, addrto, msg.value);
    }

    // Other functions and modifiers can be added as needed
}

