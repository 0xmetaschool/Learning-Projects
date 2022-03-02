# 🎯 The model of execution

## **All you need to know about The Execution Model 🚀**

## Execution model

So far, we’ve learned about the series of steps that have to happen for a transaction to execute from start to finish. Now, we’ll look at how the transaction actually executes within the VM.

The part of the protocol that actually handles processing the transactions is Ethereum’s own virtual machine, known as the Ethereum Virtual Machine (EVM).

The EVM is a Turing complete virtual machine, as defined earlier. The only limitation the EVM has that a typical Turing complete machine does not is that the EVM is intrinsically bound by gas. Thus, the total amount of computation that can be done is intrinsically limited by the amount of gas provided.  
![](https://lh5.googleusercontent.com/Bplawsohn862Xut1echN74jbW9ULOHF41HHuspjAYZCIXfTFrCEgmrZ9caNFT8UyXOBiu0HF0C9e3CfHBykcaUMkTNMWnctHAGyXxOTuVNG5d0wfmgZqACjH2Ct5ZGXZVBQRaciP)

Moreover, the EVM has a stack-based architecture. A [stack machine](https://en.wikipedia.org/wiki/Stack_machine)  is a computer that uses a last-in, first-out stack to hold temporary values.

The size of each stack item in the EVM is 256-bit, and the stack has a maximum size of 1024.

The EVM has memory, where items are stored as word-addressed byte arrays. Memory is volatile, meaning it is not permanent.

The EVM also has storage. Unlike memory, storage is non-volatile and is maintained as part of the system state. The EVM stores program code separately, in a virtual [ROM](https://en.wikipedia.org/wiki/Read-only_memory)  that can only be accessed via special instructions. In this way, the EVM differs from the typical [von Neumann architecture](https://en.wikipedia.org/wiki/Von_Neumann_architecture), in which program code is stored in memory or storage.

![](https://lh4.googleusercontent.com/V9hJWsUQGS4l6R3LK-Bo7jw2aXPU_f6etCqrnTp1xKffw_dZ6mEsRlugF1hMOQcaxA4QrZeSN-vW6_tBxt84_MJrVBSbh2h-WU2DaK1tCQtTt3l1yMWZz-3WZnlBLiV8EeNEG3hA)

The EVM also has its own language: “EVM bytecode.” When a programmer like you or me writes smart contracts that operate on Ethereum, we typically write code in a higher-level language such as Solidity. We can then compile that down to EVM bytecode that the EVM can understand.

Okay, now on to execution.

Before executing a particular computation, the processor makes sure that the following information is available and valid:

-   System state
-   Remaining gas for computation
-   Address of the account that owns the code that is executing
-   Address of the sender of the transaction that originated this execution
-   Address of the account that caused the code to execute (could be different from the original sender)
-   Gas price of the transaction that originated this execution
-   Input data for this execution
-   Value (in Wei) passed to this account as part of the current execution
-   Machine code to be executed
-   Block header of the current block
-   Depth of the present message call or contract creation stack

At the start of execution, memory and stack are empty and the program counter is zero.

PC: 0 STACK: [] MEM: [], STORAGE: {}

The EVM then executes the transaction recursively, computing the system state and the machine state for each loop. The system state is simply Ethereum’s global state. The machine state is comprised of:

-   gas available
-   program counter
-   memory contents
-   active number of words in memory
-   stack contents.

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

1) Validate (or, if mining, determine) ommers

Each ommer block within the block header must be a valid header and be within the sixth generation of the present block.

2) Validate (or, if mining, determine) transactions

The gasUsed number on the block must be equal to the cumulative gas used by the transactions listed in the block. (Recall that when executing a transaction, we keep track of the block gas counter, which keeps track of the total gas used by all transactions in the block).

3) Apply rewards (only if mining)

The beneficiary address is awarded 5 Ether for mining the block. (Under Ethereum proposal [EIP-649](https://github.com/ethereum/EIPs/pull/669), this reward of 5 ETH will soon be reduced to 3 ETH). Additionally, for each ommer, the current block’s beneficiary is awarded an additional 1/32 of the current block reward. Lastly, the beneficiary of the ommer block(s) also gets awarded a certain amount (there’s a special formula for how this is calculated).

4) Verify (or, if mining, compute a valid) state and nonce

Ensure that all transactions and resultant state changes are applied, and then define the new block as the state after the block reward has been applied to the final transaction’s resultant state. Verification occurs by checking this final state against the state trie stored in the header.

### Assignment

#### How would you rate your understanding of the Execution Model?

Rate on the scale of 1-5 (5 being the highest)

**Your response is**
