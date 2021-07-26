from brownie import KeyToken
from scripts.helpers import get_account


def main():
    account = get_account()
    KeyToken.deploy({'from': account})