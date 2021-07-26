# wallet ethereum smart contract
A multi signature ethereum wallet that only allows to withdraw funds if the owners have previously approved the transaction.

## Deploy
Setup environment variables in `.env`.
Configure `owners` and `confirmations` variables in the deploy script.
Then deploy using brownie:
```
brownie run scripts/deploy.py
```
