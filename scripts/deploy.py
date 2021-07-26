from brownie import accounts, config, MultiSignatureWallet
from scripts.helpers import get_account


def main():
    account = get_account()

    owners = [
        "0xeDeDF37CF717d1f5E9E817da0909123fbEDFF3b0",
        "0xfabE3D167f2D9e1733e380438FD93A1670172bD2"
    ]

    confirmations = 1

    MultiSignatureWallet.deploy(owners, confirmations, {'from': account})
