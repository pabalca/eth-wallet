from brownie import MultiSignatureWallet
from scripts.helpers import get_account

import time


def main():
    account = get_account()
    contract = MultiSignatureWallet[-1]
    # contract = MultiSignatureWallet.at('0x2E646BE04b1EaC9c490b7E9CBfeB98A8Aeb9c555')

    # Add transaction
    tx = contract.addTransaction(
        "0xfabE3D167f2D9e1733e380438FD93A1670172bD2", 10 ** 18, {"from": account}
    )
    tx.wait(1)

    # Sign transaction
    tx = contract.signTransaction(0, {"from": account})
    tx.wait(1)

    # Print some information
    print(f"Owners = {contract.getOwners()}")
    print(f"Confirmations required = {contract.confirmationsRequired()}")
    print(f"Transaction = {contract.getTransaction(0)}")
    print(f"Confirmations = {contract.getConfirmations(0)}")
