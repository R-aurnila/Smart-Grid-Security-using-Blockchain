pragma solidity ^0.8.18;
// SPDX-License-Identifier: MIT

contract Energy {

    // Associates each user with the number of kWh available for sale and consumption
    mapping(address => uint) prosumer;

    struct virtualStorage {
        uint expirationDate;
        uint purchasePrice; // Price at which it is purchased from the storage
        uint sellingPrice; // Price at which it is sold by the storage
        uint identifier;
        uint wallet; // TODO perhaps to be removed?
        uint32 totalCapacity;
        uint32 kWhCurrentlyStored;
        // After this date, it will only be possible to buy the remaining kWh
        bool deactivated;
    }

    mapping(address => virtualStorage[]) energyManager;
    mapping(address => bool) energyManagersMapping;
    mapping(address => bool) public allowedBuyers;

    event Buy(address prosumerAddress, address storageOwner, uint storageId, uint32 quantity, uint paid);
    event Sell(address prosumerAddress, address storageOwner, uint storageId, uint32 quantity, uint earned);
    event StorageCreated(address owner, uint id);
    event StorageEdited(address owner, uint id);

    modifier onlyEnergyManager {
    require(isEnergyManager(msg.sender), "Caller is not an energy manager");
    _;
}

    function allowUserToBuy(address userAddress) public onlyEnergyManager {
    //require(proofOfWork > 0 && proofOfWork % 2 == 0, "Invalid proof-of-work");

    //require(block.timestamp % proofOfWork == 0, "Invalid proof-of-work");

    // Grant permission to the specified user to call buyFromvirtualStorage
    allowedBuyers[userAddress] = true;
}

    function buyFromvirtualStorage(address addr, uint id, uint32 quantity, address addrto) public payable {
      require(allowedBuyers[msg.sender], "User is not allowed to buy");
    //require(addrto == msg.sender, "Address does not match the sender");
    //require(energyManager[addr].length > id);
    virtualStorage memory chosen = energyManager[addr][id];
    //require(quantity <= chosen.kWhCurrentlyStored);
    //require(msg.value >= chosen.sellingPrice * quantity); // The paid price must be enough for the quantity

    prosumer[addrto] += quantity;
    chosen.kWhCurrentlyStored -= quantity;
    energyManager[addr][id] = chosen;

    chosen.wallet += chosen.sellingPrice * quantity;

    emit Buy(addrto, addr, id, quantity, msg.value);
    }


    function sellTovirtualStorage(address addr, uint id, uint32 quantity, address addrfrom) public payable {
    //require(addrfrom == msg.sender, "Address does not match the sender");
    //require(energyManager[addr].length > id);
    virtualStorage memory chosen = energyManager[addr][id];
    //require(quantity <= chosen.totalCapacity - chosen.kWhCurrentlyStored); // The storage must have a need
    //require(prosumer[addrfrom] >= quantity); // The seller must possess enough kWh

    prosumer[addrfrom] -= quantity;
    chosen.kWhCurrentlyStored += quantity;
    //chosen.wallet -= chosen.purchasePrice * quantity;
    energyManager[addr][id] = chosen;

    // payable(addrfrom).transfer(quantity * chosen.purchasePrice);

    emit Sell(addrfrom, addr, id, quantity, quantity * chosen.purchasePrice);
    }

    function createvirtualStorage(uint32 totalCapacity, uint purchasePrice, uint sellingPrice) public payable {
        require(isEnergyManager(msg.sender));
        // When creating the storage, it is necessary to advance the money to pay those who intend to sell.
        // require(msg.value >= totalCapacity * purchasePrice);
        // There must be a positive gain in the sale of energy.
        // require(purchasePrice < sellingPrice);

        // Calculate the expiration date one day from now (in seconds)
        uint calculatedExpirationDate = block.timestamp + 86400;

        energyManager[msg.sender].push(virtualStorage(calculatedExpirationDate, purchasePrice, sellingPrice, energyManager[msg.sender].length, msg.value, totalCapacity,totalCapacity, false));

        emit StorageCreated(msg.sender, energyManager[msg.sender].length - 1);
    }

    

    function getPossessedkWh(address he) public view returns (uint) {
        return prosumer[he];
    }

    function givekWh(uint quantity) public {
        prosumer[msg.sender] += quantity;
    }



    function getAllvirtualStorage(address toCheck) public view returns (uint) {
        return energyManager[toCheck].length;
    }

    function getvirtualStorage(address addr, uint id) public view returns (uint, uint, uint, uint, uint, uint32, uint32, bool) {
        // require(energyManager[addr].length > id);
        virtualStorage storage temp = energyManager[addr][id];
        return (temp.expirationDate, temp.purchasePrice, temp.sellingPrice, temp.identifier, temp.wallet, temp.totalCapacity, temp.kWhCurrentlyStored, temp.deactivated);
    }

    function addEnergyManager(address toAdd) public {
        require(isEnergyManager(msg.sender));
        energyManagersMapping[toAdd] = true;
    }

    function isEnergyManager(address toCheck) public view returns (bool) {
        return energyManagersMapping[toCheck];
    }

    // The deploying address must be set as the first energyManager on deploy
    constructor() {
        energyManagersMapping[msg.sender] = true;
    }

    //function () public payable {}

    

    
}
