// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SellingContract {

    struct Sale {
        address addr;
        uint id;
        uint32 quantity;
        address addrfrom;
        uint received;
    }

    Sale[] public sales;

    event SaleStored(address addr, uint id, uint32 quantity, address addrfrom, uint received);

    function storeSale(address addr, uint id, uint32 quantity, address addrfrom) public payable {
        //require(msg.value > 0, "Must send a non-zero value with the transaction");

        // Store the sale details
        Sale memory newSale = Sale({
            addr: addr,
            id: id,
            quantity: quantity,
            addrfrom: addrfrom,
            received: msg.value
        });

        sales.push(newSale);

        emit SaleStored(addr, id, quantity, addrfrom, msg.value);
    }

    // Other functions and modifiers can be added as needed
}
