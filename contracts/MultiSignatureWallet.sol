// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.6;

contract MultiSignatureWallet {
    
    struct Transaction {
        address payable destination;
        uint256 value;
        bool executed;
    }

    mapping (uint => Transaction) transactions;
    uint256 public lastTransaction;

    mapping (uint256 => mapping (address => bool)) confirmations;
    uint256 public confirmationsRequired;

    mapping (address => bool) isOwner;
    address[] owners;
    

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier transactionExists(uint256 _transactionId) {
        require(transactions[_transactionId].destination != address(0), "not valid transaction");
        _;
    }

    constructor(address[] memory _owners, uint256 _confirmationsRequired ) {
        owners = _owners;
        for (uint8 i=0; i<_owners.length; i++ ){
            isOwner[_owners[i]] = true;
        }
        confirmationsRequired = _confirmationsRequired;
        lastTransaction = 0;
    }

    receive() payable external {}

    function getConfirmations(uint256 _transactionId) public view returns (uint256 count) {
        count = 0;
        for (uint8 i = 0; i < owners.length; i++ ) {
            if (confirmations[_transactionId][owners[i]] == true) {
                count += 1;
            }
        }
    }
    
    function isConfirmed(uint256 _transactionId) internal view returns (bool) {
        if (getConfirmations(_transactionId) >= confirmationsRequired) {
            return true;
        } else {
            return false;
        }
    }

    function getTransaction(uint256 _transactionId) public view returns (Transaction memory) {
        return transactions[_transactionId];
    }

    function addTransaction(address payable _destination, uint256 _value) public onlyOwner returns (uint256 transactionId) {
        transactionId = lastTransaction;
        transactions[transactionId] = Transaction(_destination, _value, false);
        lastTransaction+=1;
    }

    function signTransaction(uint256 _transactionId) public onlyOwner transactionExists(_transactionId) {
        require(confirmations[_transactionId][msg.sender], "transaction is signed");
        confirmations[_transactionId][msg.sender] = true;
    }

    function executeTransaction(uint256 _transactionId) public onlyOwner transactionExists(_transactionId) {
        require(isConfirmed(_transactionId), "confirmations required");
        require(!transactions[_transactionId].executed, "transactions already executed");
        transactions[_transactionId].executed = true;
        transactions[_transactionId].destination.transfer(transactions[_transactionId].value);
    }
    
    function getOwners() public view returns (address[] memory){
        return owners;
    }
    
}