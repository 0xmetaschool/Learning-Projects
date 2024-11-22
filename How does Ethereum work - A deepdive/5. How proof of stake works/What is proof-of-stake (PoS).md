# What is proof-of-stake (PoS)

## Ethereum: From Digging to Staking

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%201.webp)


Once upon a time, Ethereum was a goldmine. Miners would dig and dig to get a piece of the pie, their powerful computers churning away. But the digging was tiring, and the rewards were getting smaller.

So, the wise leader of Ethereum, Vitalik Buterin, had an idea. Instead of digging, people could become guardians of the mine. They'd stake their gold (ETH) to protect the mine and earn rewards for their efforts.

This was the great shift from Proof-of-Work (PoW) to Proof-of-Stake (PoS). Now, anyone with ETH could become a guardian, even if they didn't have a supercomputer.

## The Hard Fork: Transitioning from PoW to PoS

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%202.webp)


In September 2022, Ethereum underwent a historic hard fork—an essential change in the blockchain protocol that created a divergence from the previous version—moving from Proof-of-Work (PoW) to Proof-of-Stake (PoS) through **EIP-3675**. This significant upgrade revolutionized Ethereum by:

- **Streamlining Activation:** EIP-3675 made it easy for validators to join and secure the network.
- **Preserving Integrity:** It managed historical data, ensuring a smooth transition.
- **Aligning Rewards:** Validators now earn rewards proportional to their staked ETH, with penalties for dishonest behavior.

The hard fork and EIP-3675 marked a pivotal moment for Ethereum, ushering in a more sustainable and efficient blockchain future.

## Validator


![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%203.webp)


A validator in the Ethereum blockchain is a network participant responsible for securing the network and maintaining consensus. Unlike miners in Proof-of-Work (PoW) systems who compete to solve complex mathematical problems, validators are selected based on the amount of cryptocurrency they stake in the network. 

### How to become a Validator?

To become a validator, one must meet the following requirements:

- **Deposit:** Deposit 32 ETH into the deposit contract. This ETH is locked up and serves as a security deposit.
- **Software:** Run three separate pieces of software:
    - **Execution Client:** Executes transactions and smart contracts.
    - **Consensus Client:** Participates in the consensus mechanism and validates blocks.
    - **Validator Client:** Manages the validator's stake and interacts with the network.

### Validator Responsibilities

- **Block Validation:** When a new block is proposed, validators verify the validity of the transactions included in the block. This involves re-executing the transactions to ensure they adhere to the Ethereum Virtual Machine (EVM) rules.
- **Block Signature:** Validators check the signature of the block to verify that it was created by the designated block proposer.
- **Attestation:** Validators send a vote, called an attestation, in favor of the valid block across the network. This helps establish consensus and ensures that the majority of validators agree on the state of the blockchain.

## Slashing: The Penalty for Misbehavior

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%204.webp)


Ever heard of a digital time-out? That's basically what slashing is in the world of blockchain. Imagine a bunch of kids (validators) playing a game (blockchain) and one kid (validator) starts cheating or being naughty. The other kids (network) don't like that, so they give the naughty kid a digital spanking (slashing) by taking away some of his toys (staked coins).

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%205.webp)


Slashing, in essence, is the process of penalizing a validator for violating the rules of the Ethereum network. Validators, entrusted with the task of securing the blockchain and ensuring consensus, are expected to perform their duties diligently. Failure to do so can result in severe consequences, including the forfeiture of their staked Ether.

### The Three Cardinal Sins of Slashing

There are primarily three ways a validator can find themselves on the wrong side of the slashing sword:

- **Double-signing:** Validators who sign two conflicting blocks are essentially cheating. This undermines the blockchain's consensus mechanism and is a serious offense.
- **Invalid blocks:** Proposing blocks that don't follow the rules can also lead to slashing. Think of it like submitting a faulty report card: it's not acceptable.
- **Downtime:** Validators must be online and active. Going AWOL can disrupt the network, so there's a penalty for excessive downtime.

### Implications of Slashing

Slashing can have significant consequences for validators, including:

- **Loss of Staked Funds:** The primary penalty for slashing is the loss of a portion or all of the validator's staked funds. This financial loss can be substantial and serve as a powerful deterrent.
- **Reduced Voting Power:** A slashed validator's voting power within the network may be reduced, affecting their influence on the consensus process.
- **Reputation Damage:** Being slashed can damage a validator's reputation, making it difficult to attract delegators in the future.
- **Potential Exclusion from the Network:** In some cases, severely slashed validators may be permanently excluded from the network, losing their ability to participate in the consensus process.

## The Math Behind Ethereum's Proof of Stake (PoS)

Validators are chosen to propose and validate blocks based on how much ETH they stake. Here's how the math works in Ethereum’s PoS system.

### 1. Selection Probability

The more ETH a validator stakes, the higher their chance of being selected to propose a new block. This probability is calculated using the following formula:

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%206.webp)


Where:

- ETH (staked by validator) is the amount of ETH staked by the individual validator.
- ∑ ETH (staked by all validators) is the total amount of ETH staked by all validators in the network.

For example, if a validator stakes 32 ETH and the total staked ETH in the network is 100,000 ETH, their probability of being selected is:

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%207.webp)


This ensures fairness—larger stakes have a higher chance of earning rewards, but even validators with smaller stakes have the opportunity to participate.

### 2. Rewards and Slashing

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%208.webp)

Validators earn rewards for participating honestly in the network and are penalized (slashed) if they attempt to attack or behave maliciously.

**Rewards**:

Validators receive rewards for:

- Proposing new blocks.
- Attesting to the validity of blocks proposed by others.

The rewards are proportional to the amount of ETH they stake and the performance of the network (i.e., how many other validators are online and participating). The exact reward rate varies based on these factors and is dynamically adjusted by the Ethereum protocol.

**Penalty (Slashing) Formula:**

If a validator behaves maliciously or incorrectly (e.g., signs two different blocks for the same slot), a portion of their staked ETH is slashed. 

The penalty S is a percentage of their stake:

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%209.webp)

Where:

- Slash_Rate is the percentage of the staked ETH that will be slashed.

For example, if a validator stakes 32 ETH and the slash rate is 5%, the penalty would be:

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%2010.webp)


So, 1.6 ETH will be deducted from their staked amount.

### 3. Epochs and Slots


![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%2011.webp)

In Ethereum PoS, time is divided into **epochs** and **slots**:

- An **epoch** is a fixed period during which a group of validators are responsible for proposing and attesting to blocks. It is composed of 32 **slots**.
- A **slot** is a 12-second time window where a selected validator has the chance to propose a block to the blockchain. Not every slot necessarily results in a block, but it provides the opportunity for one.
- Every epoch (approximately 6.4 minutes), the validators are reshuffled to ensure randomness and improve the security of the network.

This division of time into epochs and slots ensures efficient block production while maintaining fairness and security in validator selection.

### 4. Finality and Casper FFG

Ethereum uses the **Casper FFG (Friendly Finality Gadget)** to finalize blocks. Finality means that once a block is finalized, it cannot be reverted. Casper FFG introduces the concept of **justification** and **finalization** of blocks using votes from validators.

**Finality Condition:**

A block becomes finalized if two-thirds (66%) of the validators (weighted by their stake) attest to its validity over two consecutive epochs. This ensures security and prevents malicious validators from reversing the finalized state of the blockchain.

**Voting Power:**

Validators' voting power is proportional to their stake. 

The total voting power V(total) is:

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%2012.webp)


For finality, the block must receive votes from validators representing at least two-thirds of the total voting power:

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%2013.webp)


## Proof-of-Stake Security

![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%2014.webp)

**Think of PoS like a cryptocurrency game of thrones.** To launch a 51% attack, you'd need to be the richest lord in the kingdom, owning more than half the land and peasants. But here's the twist: if you try to bend the rules and change the history of the kingdom, the other lords can vote to banish you and seize your land. So, it's like saying, 'Hey, let's commit a crime, but it's gonna cost me everything I own.' Not a very smart move, right?

Think of PoS like a cryptocurrency game of thrones. To launch a 51% attack, you'd need to be the richest lord in the kingdom, owning more than half the land and peasants.

However, unlike a traditional game of thrones, a 51% attack on a PoS network is incredibly challenging and costly. Ethereum, for instance, has a threshold of around 5 million ETH required to control more than 50% of the network. But in reality, due to the staking mechanics, an attacker would need to own more than 66% of the staked ETH to successfully execute an attack.

Furthermore, launching a 51% attack on a PoS network could be extremely risky. If detected, the network can be hard forked, effectively rendering the attacker's investment worthless. Additionally, the attacker could face significant financial losses due to penalties and the potential loss of their staked funds.

So, while a 51% attack is theoretically possible, the immense cost, risk, and potential consequences make it a highly impractical and unlikely scenario

## Pros of Proof of Stake (PoS)

| Feature | Advantages | Clarification |
| --- | --- | --- |
| Energy Usage | Minimal Power Requirements | PoS eliminates the need for vast energy resources used by PoW mining, making it a more sustainable option. |
| Financial Accessibility | Lower Financial Entry Barriers | Users can stake without expensive mining equipment, allowing broader participation from a more diverse range of individuals and small entities. |
| Economic Benefits | Passive Income Opportunities | PoS enables users to earn income simply by staking their coins, incentivizing broader network participation. |
| Transaction Throughput | Higher Efficiency | PoS blockchains typically process more transactions at lower costs, improving scalability for applications that require high transaction throughput. |
| Decentralization Potential | Wider Validator Participation | PoS allows anyone with tokens to become a validator, enhancing decentralization compared to PoW, which favors those with specialized equipment. |

## Cons of Proof of Stake (PoS)

| Feature | Disadvantages | Clarification |
| --- | --- | --- |
| Energy Usage | Not Fully Proven at Scale | Despite its promising features, PoS lacks the historical validation that PoW has for its security mechanisms and long-term viability. |
| Financial Accessibility | Large Stakeholders Hold Power | The more tokens an individual or entity holds, the more influence they can exert on transaction validation, creating risks of centralized control. |
| Economic Benefits | Validator Wealth Concentration | Wealthier participants have an inherent advantage in earning rewards and influence, creating potential inequalities in reward distribution. |
| Transaction Throughput | System Complexity | PoS networks are often more complex to manage and maintain due to intricate consensus protocols, requiring additional technical expertise. |
| Decentralization Potential | Influence of Major Stakeholders | Large validators can wield significant influence over decision-making processes, reducing the network's true decentralized nature. |

## Proof of Stake Vs. Proof of Work
![](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/refs/heads/main/assests_for_all/assests-for-eth-deep-dive/L9%20Image%2015.webp)

| Aspect | Proof of Work (PoW) | Proof of Stake (PoS) |
| --- | --- | --- |
| Consensus Mechanism | Miners compete to solve complex cryptographic puzzles to validate transactions and create new blocks. | Validators are randomly selected based on the amount of cryptocurrency they hold and are willing to "stake." |
| Energy Consumption | Extremely energy-intensive due to the need for large amounts of computational power to solve cryptographic puzzles. Bitcoin alone uses more energy than some countries. | Significantly lower energy consumption as no extensive computations are needed to validate blocks. Environmentally sustainable compared to PoW. |
| Hardware Requirements | Requires specialized and expensive  hardware (e.g., ASICs for Bitcoin) to mine profitably. Leads to centralization of mining power in large mining pools or farms with access to these high-end hardware setups. | Validators only require standard server-grade hardware, making it more accessible to a larger audience. No need for specialized hardware (e.g., ASICs), which are expensive and create centralization risks. |
| Rewards Distribution | The first miner to solve the cryptographic puzzle receives block rewards and transaction fees. | Validators earn transaction fees as rewards for validating blocks, and their income is proportional to the amount staked. |
| 51% Attack Vulnerability | A malicious actor needs to control 51% of the network's mining power to execute an attack, which requires significant investment in hardware. | An attacker would need to own 51% of the total cryptocurrency supply to execute a successful attack, making it extremely costly. |
| Transaction Speed | Transactions can be slower due to the time taken to solve puzzles, leading to congestion during peak times. | Generally offers faster transaction processing times since block creation is based on stake rather than competition. |
| Finality of Transactions | PoW requires multiple confirmations to secure finality, which can cause delays and vulnerabilities to chain reorgs, especially in scenarios of network attacks or congestion. | **Faster finality**: PoS offers quicker finalization times as blocks are confirmed faster, reducing the likelihood of chain reorganization |
| Examples | Bitcoin (BTC), Litecoin (LTC), Ethereum Classic (ETC) | Ethereum (ETH), Cardano (ADA), Sepolia Testnet |

## Conclusion

…Phew! You made it to the end. I hope.

I know there’s a lot to digest in this. If it takes you multiple reads to fully understand what’s going on, that’s totally fine. I personally read the Ethereum yellow paper, white paper, and various parts of the code base many times before grokking what was going on.

Good luck! :)


## ⚒️ A small yet important request:

This is a 100% open-source project like all the other projects on our platform. You can find the tutorial markdown files [here](https://github.com/0xmetaschool/Learning-Projects/tree/main/How%20does%20Ethereum%20work%20-%20A%20deepdive). If you find any issues in the course, please feel free to resolve it. We, at Metaschool, love love love contributions by our community and acknowledge the contributors on our [Discord](https://discord.com/invite/vbVMUwXWgc) and GitHub, too.

While you’re contributing:

1. Don’t forget to star ⭐️ our repository. We will be very thankful! ❤️
2. We are a completely free platform and we aim to stay the same, so please consider following us on [X](https://bit.ly/eth-dive-twitter) and [LinkedIn](https://bit.ly/eth-dive-linkedin) as well. 🫶

