# The Process of Transaction Execution

We’ve come to one of the most complex parts of the Ethereum protocol: the execution of a transaction. Say you send a transaction off into the Ethereum network to be processed. What happens to transition the state of Ethereum to include your transaction?

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L7%20Image%201.webp)

First, all transactions must meet an initial set of requirements in order to be executed. These include:

- The transaction must be a properly formatted RLP. “RLP” stands for “Recursive Length Prefix” and is a data format used to encode nested arrays of binary data. RLP is the format Ethereum uses to serialize objects.
- Valid transaction signature.
- Valid transaction nonce. Recall that the nonce of an account is the count of transactions sent from that account. To be valid, a transaction nonce must be equal to the sender account’s nonce.
- The transaction’s gas limit must be equal to or greater than the intrinsic gas used by the transaction. The intrinsic gas includes:

1.  a predefined cost of 21,000 gas for executing the transaction
2.  a gas fee for data sent with the transaction (4 gas for every byte of data or code that equals zero, and 68 gas for every non-zero byte of data or code)
3.  if the transaction is a contract-creating transaction, an additional 32,000 gas

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L7%20Image%202.webp)

- The sender’s account balance must have enough Ether to cover the “upfront” gas costs that the sender must pay. The calculation for the upfront gas cost is simple: First, the transaction’s gas limit is multiplied by the transaction’s gas price to determine the maximum gas cost. Then, this maximum cost is added to the total value being transferred from the sender to the recipient.

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L7%20Image%203.webp)

If the transaction meets all of the above requirements for validity, then we move on to the next step.

First, we deduct the upfront cost of execution from the sender’s balance and increase the nonce of the sender’s account by 1 to account for the current transaction. At this point, we can calculate the gas remaining as the total gas limit for the transaction minus the intrinsic gas used.

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L7%20Image%204.webp)

Next, the transaction starts executing. Throughout the execution of a transaction, Ethereum keeps track of the “substate.” This substate is a way to record information accrued during the transaction that will be needed immediately after the transaction completes. Specifically, it contains:

- Self-destruct set: a set of accounts (if any) that will be discarded after the transaction completes.
- Log series: archived and indexable checkpoints of the virtual machine’s code execution.
- Refund balance: the amount to be refunded to the sender account after the transaction. Remember how we mentioned that storage in Ethereum costs money and that a sender is refunded for clearing up storage? Ethereum keeps track of this using a refund counter. The refund counter starts at zero and increments every time the contract deletes something in storage.

Next, the various computations required by the transaction are processed.

Once all the steps required by the transaction have been processed and assuming there is no invalid state, the state is finalized by determining the amount of unused gas to be refunded to the sender. In addition to the unused gas, the sender is also refunded some allowance from the “refund balance” that we described above.

Once the sender is refunded:

- the Ether for the gas is given to the miner
- the gas used by the transaction is added to the block gas counter (which keeps track of the total gas used by all transactions in the block, and is useful when validating a block)
- all accounts in the self-destruct set (if any) are deleted

Finally, we’re left with the new state and a set of logs created by the transaction.

Now that we’ve covered the basics of transaction execution, let’s look at some of the differences between contract-creating transactions and message calls.

## Contract creation

Recall that in Ethereum, there are two types of accounts: contract accounts and externally owned accounts. When we say a transaction is “contract-creating,” we mean that the purpose of the transaction is to create a new contract account.

In order to create a new contract account, we first declare the address of the new account using a special formula. Then we initialize the new account by:

- Setting the nonce to zero
- If the sender sent some amount of Ether as value with the transaction, setting the account balance to that value
- Deducting the value added to this new account’s balance from the sender’s balance
- Setting the storage as empty
- Setting the contract’s codeHash as the hash of an empty string

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

## All you need to know about The Execution Model 🚀

## Execution model

So far, we’ve learned about the series of steps that have to happen for a transaction to execute from start to finish. Now, we’ll look at how the transaction actually executes within the VM.

The part of the protocol that actually handles processing the transactions is Ethereum’s own virtual machine, known as the Ethereum Virtual Machine (EVM).

The EVM is a Turing complete virtual machine, as defined earlier. The only limitation the EVM has that a typical Turing complete machine does not is that the EVM is intrinsically bound by gas. Thus, the total amount of computation that can be done is intrinsically limited by the amount of gas provided.  

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L7%20Image%205.webp)

Moreover, the EVM has a stack-based architecture. A [stack machine](https://en.wikipedia.org/wiki/Stack_machine) is a computer that uses a last-in, first-out stack to hold temporary values.

The size of each stack item in the EVM is 256-bit, and the stack has a maximum size of 1024.

The EVM has memory, where items are stored as word-addressed byte arrays. Memory is volatile, meaning it is not permanent.

The EVM also has storage. Unlike memory, storage is non-volatile and is maintained as part of the system state. The EVM stores program code separately, in a virtual [ROM](https://en.wikipedia.org/wiki/Read-only_memory) that can only be accessed via special instructions. In this way, the EVM differs from the typical [von Neumann architecture](https://en.wikipedia.org/wiki/Von_Neumann_architecture), in which program code is stored in memory or storage.


![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L7%20Image%206.webp)

The EVM also has its own language: “EVM bytecode.” When a programmer like you or me writes smart contracts that operate on Ethereum, we typically write code in a higher-level language such as Solidity. We can then compile that down to EVM bytecode that the EVM can understand.

Okay, now on to execution.

Before executing a particular computation, the processor makes sure that the following information is available and valid:

- System state
- Remaining gas for computation
- Address of the account that owns the code that is executing
- Address of the sender of the transaction that originated this execution
- Address of the account that caused the code to execute (could be different from the original sender)
- Gas price of the transaction that originated this execution
- Input data for this execution
- Value (in Wei) passed to this account as part of the current execution
- Machine code to be executed
- Block header of the current block
- Depth of the present message call or contract creation stack

At the start of execution, memory and stack are empty and the program counter is zero.

PC: 0 STACK: [] MEM: [], STORAGE: {}

The EVM then executes the transaction recursively, computing the system state and the machine state for each loop. The system state is simply Ethereum’s global state. The machine state is comprised of:

- gas available
- program counter
- memory contents
- active number of words in memory
- stack contents.

Stack items are added or removed from the leftmost portion of the series.

On each cycle, the appropriate gas amount is reduced from the remaining gas, and the program counter increments.

At the end of each loop, there are three possibilities:

1.  The machine reaches an exceptional state (e.g. insufficient gas, invalid instructions, insufficient stack items, stack items would overflow above 1024, invalid JUMP/JUMPI destination, etc.) and so must be halted, with any changes discarded
2.  The sequence continues to process into the next loop
3.  The machine reaches a controlled halt (the end of the execution process)

Assuming the execution doesn’t hit an exceptional state and reaches a “controlled” or normal halt, the machine generates the resultant state, the remaining gas after this execution, the accrued substate, and the resultant output.

Phew. We got through one of the most complex parts of Ethereum. Even if you didn’t fully comprehend this part, that’s okay. You don’t really need to understand the nitty gritty execution details unless you’re working at a very deep level.

## How a block gets finalized

Finally, let’s look at how a block of many transactions gets finalized.

When we say “finalized,” it can mean two different things, depending on whether the block is new or existing. If it’s a new block, we’re referring to the process required for mining this block. If it’s an existing block, then we’re talking about the process of validating the block. In either case, there are four requirements for a block to be “finalized”:

1. Validate (or, if mining, determine) ommers

Each ommer block within the block header must be a valid header and be within the sixth generation of the present block.

2. Validate (or, if mining, determine) transactions

The gasUsed number on the block must be equal to the cumulative gas used by the transactions listed in the block. (Recall that when executing a transaction, we keep track of the block gas counter, which keeps track of the total gas used by all transactions in the block).

3. Apply rewards (only if mining)

The beneficiary address is awarded 5 Ether for mining the block. (Under Ethereum proposal [EIP-649](https://github.com/ethereum/EIPs/pull/669), this reward of 5 ETH will soon be reduced to 3 ETH). Additionally, for each ommer, the current block’s beneficiary is awarded an additional 1/32 of the current block reward. Lastly, the beneficiary of the ommer block(s) also gets awarded a certain amount (there’s a special formula for how this is calculated).

4. Verify (or, if mining, compute a valid) state and nonce

Ensure that all transactions and resultant state changes are applied, and then define the new block as the state after the block reward has been applied to the final transaction’s resultant state. Verification occurs by checking this final state against the state trie stored in the header.