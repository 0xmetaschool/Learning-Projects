# 🔮 How mining of proof of work happens?

## **How to Mine Proof of Work 🤖**

## Mining proof of work

The “Blocks” section briefly addressed the concept of block difficulty. The algorithm that gives meaning to block difficulty is called Proof of Work (PoW).

Ethereum’s proof-of-work algorithm is called “[Ethash](https://github.com/ethereum/wiki/wiki/Ethash)” (previously known as Dagger-Hashimoto).

The algorithm is formally defined as:

![](https://lh5.googleusercontent.com/GwsfqXOsZ7XvLEKMtKxWhFfrmuccepUl5fnnnhj6pwt4hrTUTMT9Zh6qBA3fheuL5Prsd8hoJ3_ZvVN6Vha7AqM5CtSU4ramyim-R1hrFoH6B7dyrS71blt4SKUS4ixVHl2yvW_F)

where m is the mixHash, n is the nonce, Hn is the new block’s header (excluding the nonce and mixHash components, which have to be computed), Hn is the nonce of the block header, and d is the [DAG](https://en.wikipedia.org/wiki/Directed_acyclic_graph), which is a large data set.

In the “Blocks” section, we talked about the various items that exist in a block header. Two of those components were called the mixHash and the nonce. As you may recall:

-   mixHash is a hash that, when combined with the nonce, proves that this block has carried out enough computation
-   nonce is a hash that, when combined with the mixHash, proves that this block has carried out enough computation

The PoW function is used to evaluate these two items.

How exactly the mixHash and nonce are calculated using the PoW function is somewhat complex, and something we can delve deeper into in a separate post. But at a high level, it works like this:

A “seed” is calculated for each block. This seed is different for every “epoch,” where each epoch is 30,000 blocks long. For the first epoch, the seed is the hash of a series of 32 bytes of zeros. For every subsequent epoch, it is the hash of the previous seed hash. Using this seed, a node can calculate a pseudo-random “cache.”

This cache is incredibly useful because it enables the concept of “light nodes,” which we discussed previously in this post. The purpose of light nodes is to afford certain nodes the ability to efficiently verify a transaction without the burden of storing the entire blockchain dataset. A light node can verify the validity of a transaction based solely on this cache because the cache can regenerate the specific block it needs to verify.

Using the cache, a node can generate the DAG “dataset,” where each item in the dataset depends on a small number of pseudo-randomly-selected items from the cache. In order to be a miner, you must generate this full dataset; all full clients and miners store this dataset, and the dataset grows linearly with time.

Miners can then take random slices of the dataset and put them through a mathematical function to hash them together into a “mixHash.” A miner will repeatedly generate a mixHash until the output is below the desired target nonce. When the output meets this requirement, this nonce is considered valid and the block can be added to the chain.

Mining as a security mechanism

Overall, the purpose of the PoW is to prove, in a cryptographically secure way, that a particular amount of computation has been expended to generate some output (i.e. the nonce). This is because there is no better way to find a nonce that is below the required threshold than to enumerate all the possibilities. The outputs of repeatedly applying the hash function have a uniform distribution, and so we can be assured that, on average, the time needed to find such a nonce depends on the difficulty threshold. The higher the difficulty, the longer it takes to solve for the nonce. In this way, the PoW algorithm gives meaning to the concept of difficulty, which is used to enforce blockchain security.

What do we mean by blockchain security? It’s simple: we want to create a blockchain that EVERYONE trusts. As we discussed previously in this post, if more than one chain existed, users would lose trust, because they would be unable to reasonably determine which chain was the “valid” chain. In order for a group of users to accept the underlying state that is stored on a blockchain, we need a single canonical blockchain that a group of people believes in.

This is exactly what the PoW algorithm does: it ensures that a particular blockchain will remain canonical into the future, making it incredibly difficult for an attacker to create new blocks that overwrite a certain part of history (e.g. by erasing transactions or creating fake transactions) or maintain a fork. To have their block validated first, an attacker would need to consistently solve for the nonce faster than anyone else in the network, such that the network believes their chain is the heaviest chain (based on the principles of the GHOST protocol we mentioned earlier). This would be impossible unless the attacker had more than half of the network mining power, a scenario known as the [majority 51% attack](https://en.bitcoin.it/wiki/Majority_attack).

![](https://lh6.googleusercontent.com/egO90FyoMzyzswg5MPbdn7FQ7hZmjBHtfQ5dXW_SuqOUDGOOBvPxYNJhuYACdRQAxJtKLeUu9CRnN2J4F7pYUz44vmf-EyQ7ov7nYGRUimxCtdtynn14W613yYo-UCjQYVytlWBW)

## Mining as a wealth distribution mechanism

Beyond providing a secure blockchain, PoW is also a way to distribute wealth to those who expend their computation for providing this security. Recall that a miner receives a reward for mining a block, including:

-   a static block reward of 5 ether for the “winning’” block (soon to be [changed to 3 ether](https://github.com/ethereum/EIPs/pull/669))
-   the cost of gas expended within the block by the transactions included in the block
-   an extra reward for including ommers as part of the block

In order to ensure that the use of the PoW consensus mechanism for security and wealth distribution is sustainable in the long run, Ethereum strives to instill these two properties:

-   Make it accessible to as many people as possible. In other words, people shouldn’t need specialized or uncommon hardware to run the algorithm. The purpose of this is to make the wealth distribution model as open as possible so that anyone can provide any amount of computing power in return for Ether.
-   Reduce the possibility for any single node (or small set) to make a disproportionate amount of profit. Any node that can make a disproportionate amount of profit means that the node has a large influence on determining the canonical blockchain. This is troublesome because it reduces network security.

In the Bitcoin blockchain network, one problem that arises in relation to the above two properties is that the PoW algorithm is a SHA256 hash function. The weakness with this type of function is that it can be solved much more efficiently using specialized hardware, also known as ASICs.

In order to mitigate this issue, Ethereum has chosen to make its PoW algorithm ([Ethhash](https://github.com/ethereum/wiki/wiki/Ethash)) sequentially memory-hard. This means that the algorithm is engineered so that calculating the nonce requires a lot of memory AND bandwidth. The large memory requirements make it hard for a computer to use its memory in parallel to discover multiple nonces simultaneously, and the high bandwidth requirements make it difficult for even a super-fast computer to discover multiple nonce simultaneously. This reduces the risk of centralization and creates a more level playing field for the nodes that are doing the verification.

One thing to note is that Ethereum is transitioning from a PoW consensus mechanism to something called “proof-of-stake”. This is a beastly topic of its own that we can hopefully explore in a future post. ☺️

## Conclusion

…Phew! You made it to the end. I hope?

There’s a lot to digest in this post, I know. If it takes you multiple reads to fully understand what’s going on, that’s totally fine. I personally read the Ethereum yellow paper, white paper, and various parts of the code base many times before grokking what was going on.

Good luck! :)

### Assignment

#### Do you think this lesson will help you 'mine proof of work'?

Answer in "Yes" or "No"

**Your response is**
