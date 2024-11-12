# Smart Grid Security using Blockchain

This project develops a blockchain-based energy trading system using three smart contracts to manage energy transactions and improve security in the smart grid. The system allows the buying and selling of energy through smart contracts, with a decentralized and secure transaction system for both users and energy sales.

## Table of Contents

- [Introduction](#introduction)
- [Smart Contracts](#smart-contracts)
  - [Energy.sol](#energy-sol)
  - [Userpart.sol](#userpart-sol)
  - [Sales.sol](#sales-sol)
- [Installation](#installation)
- [Usage](#usage)

## Introduction

This project leverages blockchain technology to create a secure energy trading system within a smart grid. It features three smart contracts to handle energy transactions, improving the efficiency and security of energy buying and selling activities. The system is designed to store transaction data in a decentralized manner, reducing the risk of fraud and enhancing transparency.

## Smart Contracts

### Energy.sol
- **Purpose**: Manages virtual energy units for buying and selling energy.
- **Description**: This contract stores energy units as virtual assets and allows users to buy and sell energy from the grid.
  
### Userpart.sol
- **Purpose**: Records user purchase transactions.
- **Description**: A simple contract that tracks and stores user transaction data when they purchase energy from the system.
  
### Sales.sol
- **Purpose**: Logs energy sales transactions.
- **Description**: This contract stores the details of energy sales transactions, including the amount of energy sold and the buyer's information.

## Installation

### Prerequisites

- Solidity compiler
- Ethereum wallet (e.g., MetaMask)
- Truffle or Remix IDE for deploying contracts

### Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/smart-grid-security-blockchain.git
   cd smart-grid-security-blockchain
   ```

2. Deploy Contracts

- Deploy the three smart contracts using your preferred Ethereum development environment, such as Truffle or Remix IDE.
- For Truffle, ensure to configure your `truffle-config.js` to connect to a local or test Ethereum network.

3. Verify Deployment

- After deployment, verify that all three contracts are successfully deployed on the Ethereum blockchain. You can interact with the contracts using Remix or a DApp frontend.

## Usage

Once the contracts are deployed, the system allows users to:

1. **Buy and Sell Energy**: Users can interact with the `Energy.sol` contract to buy and sell energy units.
2. **View User Purchase Transactions**: The `Userpart.sol` contract stores details of user purchases.
3. **Track Energy Sales**: The `Sales.sol` contract logs the energy sales transactions.








   
 
