# 🐝 How are transactions executed?

## **The Process of Transaction Execution 😍**

We’ve come to one of the most complex parts of the Ethereum protocol: the execution of a transaction. Say you send a transaction off into the Ethereum network to be processed. What happens to transition the state of Ethereum to include your transaction?

![](https://lh6.googleusercontent.com/6eNqO71lOP86G7T87dczDJBStjAxz6vL8Ts4FHnJqL_kORO2Y8twQ7hZqII7ELHSlR61z6y42-Q2B2Q7nkjc5muQjVrgP0FFob4XeKk_0-f-cR6ViWd46-s_wVy8K3QeQEtaFmZQ)

First, all transactions must meet an initial set of requirements in order to be executed. These include:

-   The transaction must be a properly formatted RLP. “RLP” stands for “Recursive Length Prefix” and is a data format used to encode nested arrays of binary data. RLP is the format Ethereum uses to serialize objects.
-   Valid transaction signature.
-   Valid transaction nonce. Recall that the nonce of an account is the count of transactions sent from that account. To be valid, a transaction nonce must be equal to the sender account’s nonce.
-   The transaction’s gas limit must be equal to or greater than the intrinsic gas used by the transaction. The intrinsic gas includes:

1.  a predefined cost of 21,000 gas for executing the transaction
2.  a gas fee for data sent with the transaction (4 gas for every byte of data or code that equals zero, and 68 gas for every non-zero byte of data or code)
3.  if the transaction is a contract-creating transaction, an additional 32,000 gas

![](https://lh3.googleusercontent.com/Ofb7zpp4CQvQRWQnnpjdWoNhgiPmMfiKPXR6NIJZbjhUl0Byea5lCFn60AmmDgxNU4a06gDSWpO656IN3HvPRFbjsRnLNiglTUF-sfZDkhIgNvL6emZCsU_qFBT0unpSiDNatYBh)

-   The sender’s account balance must have enough Ether to cover the “upfront” gas costs that the sender must pay. The calculation for the upfront gas cost is simple: First, the transaction’s gas limit is multiplied by the transaction’s gas price to determine the maximum gas cost. Then, this maximum cost is added to the total value being transferred from the sender to the recipient.

![](https://lh6.googleusercontent.com/chVl451TDYVknE9ZbsqPi_LMI2lLoihApaIYdn2gU3_ld3D5CLPH4ERlnGNzN9aYmTjuOC1D2wZpCTd60YhIrDJaemNHEX35CZmqDh03AGkptq8uejGAkAKhyiX2CaN5cAJkCakq)

If the transaction meets all of the above requirements for validity, then we move on to the next step.

First, we deduct the upfront cost of execution from the sender’s balance and increase the nonce of the sender’s account by 1 to account for the current transaction. At this point, we can calculate the gas remaining as the total gas limit for the transaction minus the intrinsic gas used.

**![](https://lh6.googleusercontent.com/CRdp6yuD6D5eEU3ZK0H_jJneeB99txnCb1QwJYSie4RH3KGAE84BNSSWW0NWl-k_DHNuRY8kjSRHMeSYmysfZrWqTOaAsO0SsTnywVW8sXWj9yxTYshl1dmELFBYIFE0zroTpiEf)**

Next, the transaction starts executing. Throughout the execution of a transaction, Ethereum keeps track of the “substate.” This substate is a way to record information accrued during the transaction that will be needed immediately after the transaction completes. Specifically, it contains:

-   Self-destruct set: a set of accounts (if any) that will be discarded after the transaction completes.
-   Log series: archived and indexable checkpoints of the virtual machine’s code execution.
-   Refund balance: the amount to be refunded to the sender account after the transaction. Remember how we mentioned that storage in Ethereum costs money and that a sender is refunded for clearing up storage? Ethereum keeps track of this using a refund counter. The refund counter starts at zero and increments every time the contract deletes something in storage.

Next, the various computations required by the transaction are processed.

Once all the steps required by the transaction have been processed and assuming there is no invalid state, the state is finalized by determining the amount of unused gas to be refunded to the sender. In addition to the unused gas, the sender is also refunded some allowance from the “refund balance” that we described above.

Once the sender is refunded:

-   the Ether for the gas is given to the miner
-   the gas used by the transaction is added to the block gas counter (which keeps track of the total gas used by all transactions in the block, and is useful when validating a block)
-   all accounts in the self-destruct set (if any) are deleted

Finally, we’re left with the new state and a set of logs created by the transaction.

Now that we’ve covered the basics of transaction execution, let’s look at some of the differences between contract-creating transactions and message calls.

## Contract creation

Recall that in Ethereum, there are two types of accounts: contract accounts and externally owned accounts. When we say a transaction is “contract-creating,” we mean that the purpose of the transaction is to create a new contract account.

In order to create a new contract account, we first declare the address of the new account using a special formula. Then we initialize the new account by:

-   Setting the nonce to zero
-   If the sender sent some amount of Ether as value with the transaction, setting the account balance to that value
-   Deducting the value added to this new account’s balance from the sender’s balance
-   Setting the storage as empty
-   Setting the contract’s codeHash as the hash of an empty string

Once we initialize the account, we can actually create the account, using the init code sent with the transaction (see the “Transaction and messages” section for a refresher on the init code). What happens during the execution of this init code is varied. Depending on the constructor of the contract, it might update the account’s storage, create other contract accounts, make other message calls, etc.

As the code to initialize a contract is executed, it uses gas. The transaction is not allowed to use up more gas than the remaining gas. If it does, the execution will hit an out-of-gas (OOG) exception and exit. If the transaction exits due to an out-of-gas exception, then the state is reverted to the point immediately prior to the transaction. The sender is not refunded the gas that was spent before running out.

Boo hoo.

However, if the sender sent any Ether value with the transaction, the Ether value will be refunded even if the contract creation fails. Phew!

If the initialization code executes successfully, a final contract-creation cost is paid. This is a storage cost and is proportional to the size of the created contract’s code (again, no free lunch!) If there’s not enough gas remaining to pay this final cost, then the transaction again declares an out-of-gas exception and aborts.

If all goes well and we make it this far without exceptions, then any remaining unused gas is refunded to the original sender of the transaction, and the altered state is now allowed to persist!

Hooray!

## Message calls

The execution of a message call is similar to that of contract creation, with a few differences.

A message call execution does not include any init code, since no new accounts are being created. However, it can contain input data, if this data was provided by the transaction sender. Once executed, the message calls also have an extra component containing the output data, which is used if a subsequent execution needs this data.

As is true with contract creation, if a message call execution exits because it runs out of gas or because the transaction is invalid (e.g. stack overflow, invalid jump destination, or invalid instruction), none of the gas used is refunded to the original caller. Instead, all of the remaining unused gas is consumed, and the state is reset to the point immediately prior to balance transfer.

Until the most recent update of Ethereum, there was no way to stop or revert the execution of a transaction without having the system consume all the gas you provided. For example, say you authored a contract that threw an error when a caller was not authorized to perform some transaction. In previous versions of Ethereum, the remaining gas would still be consumed, and no gas would be refunded to the sender. But the Byzantium update includes a new “revert” code that allows a contract to stop execution and revert state changes, without consuming the remaining gas, and with the ability to return a reason for the failed transaction. If a transaction exists due to revert, then the unused gas is returned to the sender.

### Assignment

#### How would you rate your understanding of the process of Transaction Execution?

Rate on the scale of 1-5 (5 being the highest)

**Your response is**
