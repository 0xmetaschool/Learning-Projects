# Core Workflow

Alright, grab your popcorn and get ready for the main event! In the last lesson, we explored the inner workings of the Satoshi Plus algorithm, and now it's showtime! Let's see how Core puts this clever contraption to work to elect its very own validators. We will also delve into the rewards given to these validators for keeping the network humming and how these rewards are dished out.

## Overview of how Core functions

Ever wondered how Core blockchain actually works? It's a dynamic collaboration, a well-orchestrated performance with these lead roles: Bitcoin miners, CORE/BTC holders/stakers, and validators.

On one side, we have the Bitcoin miners, the powerhouse of the operation. They contribute their raw computing power, also known as hash power, to safeguard the Core network chain. It's like having a legion of security experts constantly patrolling, ensuring that everything remains safe and sound.

Token holders also play a crucial role in electing validators. CORE token holders delegate their tokens through a process called staking to cast their votes for who they believe should be responsible for processing transactions and adding new blocks to the blockchain. Bitcoin holders also participate in the election process through a unique Non-Custodial BTC Staking mechanism, allowing them to earn rewards and have a say in the network's governance without giving up control of their Bitcoin.

The elected validators are the choreographers of the network, taking turns to process transactions and create new blocks on the blockchain with meticulous precision. Think of it like a relay race, where each validator seamlessly passes the baton to the next, maintaining a smooth and efficient flow.

This beautiful dance between security and efficiency, fueled by the collaboration of Bitcoin miners, CORE token holders, and validators, with a unique emphasis on the participation of BTC holders through the Non-Custodial BTC Staking, is what makes Core so unique.

## The Validator election

### Rounds, Slots, and Epochs

Imagine the Core blockchain as a bustling city with its internal clock. This clock is divided into "rounds," each lasting roughly 24 hours, although the exact duration can vary slightly depending on network conditions. During each round, the city elects its leaders, known as validators, who are responsible for processing transactions and maintaining the integrity of the blockchain.

Think of it like a relay race, with each validator taking a turn (called a "slot") to add a new block to the chain. A slot is incredibly short, just three seconds each, ensuring a constant flow of activity and swift transaction processing. Every 10 minutes, an "epoch" occurs, acting as a checkpoint to ensure all the validators are doing their jobs correctly and maintaining the network's security and efficiency.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXdlYuE2tYcz3dgCWc5ypp9oKeTyZ4kn-VrBwR2EBKH3vKNJYU6wTUGXT1txakyendBG4rY3nqJBSp6lIFaNCPxpVb8JpVAG5D8l5RkjWTECRCLfbvg6z9CkHOzYzpgdF2UoEG20kvvjl_tCn87wrTK0Uj-R?key=RMbE3SnA3hsbj7mtDPGw4Q](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L6%20P1.webp?raw=true)

### The Hybrid Score

So, how does this city choose its leaders? It's not a high school popularity contest, where the coolest kid wins by default. Instead, it's a carefully balanced process that takes into account both community support and technical contributions. The key to becoming a validator on Core lies in the "hybrid score," a comprehensive evaluation of a validator’s strengths and contributions. Let's break it down.

The hybrid score is like a final grade in school, reflecting a student's performance in multiple subjects. It's a numerical representation of a validator's overall qualifications, taking into account their popularity within the community, their reputation among Bitcoin holders, and the amount of hash power delegated to them. The higher the score, the better the candidate's chances of being elected as a validator.

### The Three Pillars of Validator Success

To be successfully elected as a validator on Core, three factors matter:

**1**. **Staked CORE: The Community's Vote of Confidence**
  - Imagine this as the popular vote. The more CORE tokens (Core's native currency) that are staked, or locked up, with a validator, the higher their score. It's like citizens casting their ballots for the candidate they believe in, showing their trust and confidence in their leadership. The more votes a candidate gets, the more popular they are, and the better their chances of winning.
  
**2**. **Staked Bitcoin: The Cross-Chain Seal of Approval**
  - Bitcoin holders from outside the Core community can also show their support by staking their BTC with a validator through the Non-Custodial BTC Staking mechanism. This means they can participate in Core's governance and earn rewards without giving up control of their Bitcoin. This cross-chain endorsement, secured through innovative technology, acts like a seal of approval from neighboring cities, recognizing the validator's capabilities and potential. It's like getting a glowing recommendation from a respected figure outside your own community.
  
**3**. **Hash Power Delegation: A Measure of Security Contribution**
  - Bitcoin miners, the backbone of Bitcoin's security, also play a crucial role. They can flex their computing power (hash power) by delegating it to a specific validator on the Core blockchain. This act is like a security firm lending its resources to protect the city. In return for their support, miners receive CORE tokens as a reward—a sweet deal for everyone involved! It's important to note that this delegated hash power doesn't just show a validator's technical capabilities but is a direct contribution to the security of the entire Core blockchain.

### The Winning Formula: A Delicate Balance

The hybrid score isn't just a simple popularity vote; it's a carefully crafted formula that balances all three factors:

Hybrid Score = (rHp / tHp) * m + ((rSp + rBp * n) / (tSp + tBp * n)) * (1 - m)

![https://lh7-us.googleusercontent.com/docsz/AD_4nXc8N_ixDcOhelhGn0cSiWUoGT7KYj5DgSI8wkvHNWBcfVahHutafLVsA85EIK3s63M-0KqyvRmbvye7E-uL43Jr3w2xsiifE39wNtbcaIJIfFrD-wsFYagCLcfbKi21ryXu2xKy7PanP-9zy2qCIDcMnQpy?key=RMbE3SnA3hsbj7mtDPGw4Q](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L6%20P2.webp?raw=true)

Okay, we know this looks like a bunch of gibberish, but bear with us! Here's the breakdown:

- **The Hash Power Factor:** (rHp / tHp) * m
    - This part of the equation is like a pie chart representing the total hash power dedicated to Core blockchain.
    - rHp is the slice of that pie a validator receives – the more hash power they get from Bitcoin miners, the bigger their slice.
    - 'm' is a weighting factor that adjusts how important this "hash power slice" is in the final score. Think of it like a volume knob that can be turned up or down to fine-tune the balance between popularity and security contribution.
- **The Staked Tokens Factor:** ((rSp + rBp * n) / (tSp + tBp * n)) * (1 - m)
    - This is another pie chart, this time representing the total staked tokens (CORE and Bitcoin).
    - The validator's slice grows as more tokens are staked with them, showing the level of trust and investment they've earned from the community.
    - 'n' is a weighting factor that determines how much each staked Bitcoin counts compared to each staked CORE token, like adjusting the value of different currencies.
    - '(1-m)' is the counterbalance to the hash power factor, ensuring that staked tokens have a fair say in the election.

This formula ensures that the hybrid score is a fair and balanced representation of a validator's overall qualifications, taking into account both community support and contributions to network security. It's like a well-rounded assessment of a candidate's leadership potential, considering their popularity, experience, and skills. At the end of each round, the 23 candidates with the highest hybrid scores are elected as validators. They are the backbone of the Core network, responsible for its smooth and efficient operation.

### The Validator Duty

Being a validator is a rewarding job, but it comes with responsibilities. Validators are incentivized to do their job well through block rewards and transaction fees. However, they also face consequences if they don't. If a validator misbehaves or fails to uphold their duties, they can be "slashed" meaning they lose a portion of their rewards or even their initial stake. In more severe cases, they can be temporarily "jailed" (removed from the network) or even permanently banned for stuff like double-signing (maliciously validating two conflicting blocks).

![https://lh7-us.googleusercontent.com/docsz/AD_4nXe2G5XLD_dg-u4JLiw2HKgksY-ege-H9G4ASwXQ04LIVNYQEuq54XlXmq_n0zsxiEYK8moMC6UFzb8YQdGknHjNC-5MckA_y7_Ekyz57j3eleqjQx4efCFKVsuqhx5YEXkqFdAr6J0eoMxKw8dAswMhKMNW?key=RMbE3SnA3hsbj7mtDPGw4Q](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L6%20P3.webp?raw=true)

**Block Production: Building the Chain**

Once elected, validators take turns adding new blocks to the blockchain. They collect transactions, verify their validity, and package them into blocks, which are then added to the ever-growing chain. This process is essential for maintaining the network's security, ensuring that all transactions are legitimate and irreversible.

### The Core Advantage: A Resilient and Dynamic Network

By combining community support and technical expertise through its unique hybrid scoring system, Core ensures that its leaders are not only popular but also capable of maintaining a secure and efficient blockchain. This decentralized approach, coupled with a system of rewards and penalties, makes Core a resilient and dynamic platform.

## Rewards

In any successful community, there needs to be an incentive to contribute. In Core blockchain, a well-designed reward system is the reason that keeps everyone motivated. By rewarding validators, delegators, and even those who help maintain the network infrastructure.

Core validators get rewarded for keeping the network safe and running by processing transactions and building new blocks. Validators earn rewards in three main categories:

- **Block rewards:** These are freshly minted CORE tokens distributed with each new block created.
- **Transaction fees:** A portion of the fees collected from the block created by the validators. This incentivizes them to prioritize processing transactions efficiently to maximize their fee income.
- **Staking rewards:** Validators share a portion of their block rewards and transaction fees with the users who delegated their CORE/BTC/Hash Power to them. This creates a win-win situation: delegators earn passive income for supporting the network, and validators are motivated to perform well to attract more delegators.

Validators get 90% of base rewards that are distributed after each round, with 10% going to a System Reward Contract. Validators can keep a commission before sharing the remaining 90% with their delegators (CORE stakers, BTC stakers, PoW delegators). The more validators share, the more attractive they become to attract delegators and boost their earnings.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXedgm6bBy3MiS3C-S9CyoR64OL_5nU9jOpu4cJ9eQKBopsIx-S67gkEgSjKVEYk5J_t5sTeRhkoiqFoK928cKDu_KKP0yzqiaRaKuMJowhe7qOPzpfIC5pot7opgmIf-Ga9JKhIZxnt3kyeMfnszFB9TqI0?key=RMbE3SnA3hsbj7mtDPGw4Q](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L6%20P4.webp?raw=true)

### How Rewards are Calculated and Distributed

A somewhat complex mathematical formula determines the exact split,

![https://lh7-us.googleusercontent.com/docsz/AD_4nXeJYN7rrTbBJvqpbZB62rdjT0_HLKTowp2C42NolBSK3VvaRahrW6Og4hepnZGSZF-toVfcy8HhDraj8QNGJwWOoO-bFUr1nW7o2w13FjtKyF0Ca0rG8LZxy9bEHRVZ5u0O_9P5oCn-O21W4z66qaOiAsXI?key=RMbE3SnA3hsbj7mtDPGw4Q](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L6%20P5.webp?raw=true)

In summary, we can say that it depends on two key factors:

- **Block production rate:** This refers to the speed at which new blocks are added to the chain. The faster the blocks are added, the more rewards get distributed, but also get diluted among more validators.
- **Total staked amount:** The more CORE/BTC staked across the network, the more "spread out" the rewards become. Imagine a fixed pool of rewards being divided among a larger group.

### Relayer and Verifier Rewards

Earlier, we mentioned that base rewards are calculated and distributed when the last block of a round is mined, with 90% going to the validators and 10% to the System Rewards Contract. The System Reward Contract is set up to accumulate rewards for relayers and verifiers.

Remember how we discussed in the previous lessons that Bitcoin miners delegate to validators by writing some information into the headers of Bitcoin blocks? Well, **Relayers** are responsible for sending those block headers to Core blockchain. For this cross-chain communications work, they are given a portion of the base system rewards and transaction fees. Relayer rewards are distributed in batches, every 100 Bitcoin blocks.

The **Verifiers** in turn act as vigilant watchmen who constantly monitor validator behavior. If they detect malicious activity like double-signing, they report it. Upon successful verification, the System Rewards Contract immediately rewards them in the same transaction.

The current maximum caps of rewards held by the System Reward Contract are 10 million CORE and 1 million CORE for relayers and verifiers, respectively. Any excess CORE rewards are burnt.

## Security

Even though Blockchain technology offers a secure and decentralized way to manage data and transactions, it's not immune to malicious actors who might try to disrupt or manipulate the system. Core employs a multi-layered security approach to handle these threats.

There are two main categories of attacks that blockchain projects need to be vigilant against:

- **Network Attacks:** These attacks target individual nodes or users to steal funds, disrupt transaction processing, or spread misinformation. For example,
    - Double Spending Attacks: An attempt to spend the same cryptocurrency more than once.
    - 51% Attacks: A situation where a single entity or group controls more than 50% of the network's computing power, allowing them to manipulate the blockchain.
    - Sybil Attacks: An attack where a single entity creates multiple fake identities to gain control or influence over a network.
    - Long-Range Attacks: An attack where a malicious actor tries to replace a significant portion of the blockchain's history with a fraudulent version.
- **Governance Attacks:** These attacks specifically target the decision-making process of the blockchain. Attackers exploit vulnerabilities in the voting or proposal system to gain control or push through changes that benefit them, not the network's health. (e.g., Bribery, Exploiting Voting Mechanisms)

![https://lh7-us.googleusercontent.com/docsz/AD_4nXfI0yqCO34tZXyJIJNe0UDvQEEYYIzko7TD0wPN749neeaT8MfIv2kuhNB3X0g2z5r3Cc7XgUUYGIXMV_RtSmxDNn4i67TDsQXgIgTKP8eg1sy1_5PDstLbj24KlDbBrn7WLLVmzqkhy3dVRm3uOvRCyj-v?key=RMbE3SnA3hsbj7mtDPGw4Q](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L6%20P7.webp?raw=true)

### The Multi-Layered Security Approach

Core safeguards the network through a combination of techniques:

- **Geographic Dispersion:** By spreading validator nodes across various locations, it becomes much harder for attackers to compromise a majority of the network, thus significantly reducing the risk of 51% attacks.
- **Hybrid Consensus Mechanism:** Core's blend of DPoW (Delegated Proof of Work), DPoS (Delegated Proof of Stake), Non-Custodial BTC Staking, and meticulous validator selection bolsters security on multiple fronts. For example, the round-robin block mining process eliminates the risk of "selfish mining" attacks. The requirement for staked CORE tokens and Non-Custodial BTC Staking to participate in validator elections helps to ensure that validators have a vested interest in the network's success and are less likely to engage in malicious behavior.
- **Security Through Incentivization:** The Satoshi Plus system creates a harmonious incentive structure. Miners and stakers, using both CORE and Bitcoin, are rewarded with CORE tokens. This aligns everyone's interests with the network's long-term health and security, discouraging malicious behavior that could harm the network.

## Wrap Up

And there you have it – a behind-the-scenes look at Core's validator selection process. It's a balancing act of community trust, external validation, and technical prowess, all meticulously calculated through the hybrid score formula. This ingenious system ensures that only the most deserving candidates rise to the top, maintaining the network's integrity and security. So next time you hear about Core's validators, remember, that it's not just a popularity contest; it's a carefully orchestrated symphony of trust, technology, and collaboration.
