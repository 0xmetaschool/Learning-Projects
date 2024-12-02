# The History of Core

Hey there Developers! In the last chapter, we gave you a sneak peek into the Core blockchain. Now, as blockchain enthusiasts, we know you guys are super pumped to start the building part, but as the Developer's code of conduct would dictate, one should understand the ‘why’ before they get to the ‘how’.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXcQV3wiVVkmG81fmn8Hqb3Vqpj0T3aODwi4FUMk4P__IZsHCPNHcCvGOF4siuCiJdxaTmBr5upDX24SDt9Z1aE75MciL_kk4P8TyKpnTfPjPZedn4f4_FZwm2mfCMQk213fzD1J6cLbjLfI6ty27ReUC15J?key=vtLTtJHs5MQqzL6kDiBltQ](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%201%20images/L4%20P1.webp?raw=true)

So, in this lesson, we will be looking into why the Core was conceptualized in the first place. So without further ado, let’s dive into the history of Core.

## Introduction to Blockchain Trilemma

Ready for some truth? No blockchain is perfect. This statement lies at the heart of the Blockchain Trilemma. When designing blockchains, developers often face a trade-off between three key factors: security, scalability, and decentralization. Improving one of these aspects often comes at the expense of the others, hence the Trilemma.

- **Security** is crucial to prevent data compromises and tampered transactions.
- **Scalability** involves handling increasing amounts of transactions without sacrificing speed or efficiency.
- **Decentralization** ensures no single entity controls the network, maintaining trust and resilience

![https://lh7-us.googleusercontent.com/docsz/AD_4nXcUSkSXrmEMCn7m9p_pJoyQ66mH1N6IAO19vRKNhk3CtTmnP_iCgmZ0-avJ0aADsIKV8qSX7O8FnIwfe-qultUoaluoWJUEJ1F2ivklNAWZ5DuZBS1-ymK8EEFem_mos5LkMgQW-qZXrJLn4Dr4j5dqHo0?key=vtLTtJHs5MQqzL6kDiBltQ](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%201%20images/L4%20P2.webp?raw=true)

Every blockchain aims to solve the trilemma, each with its unique features. This trend began with Bitcoin, the original blockchain network.

### Bitcoin & Ethereum: Strengths and Weaknesses

**Bitcoin** excels in security and decentralization using the Proof of Work (PoW) consensus mechanism. Miners validate transactions and generate new blocks by solving complex puzzles, ensuring security, and distributing power. However, Bitcoin struggles with scalability, leading to slower transactions and higher fees during peak usage.

**Ethereum** introduced smart contracts, aiming to be a decentralized world computer. It addressed some of Bitcoin's scalability issues with gas fees and layer 2 solutions. However, as Ethereum scaled, it faced challenges in maintaining decentralization while handling a growing number of transactions.

Today, many blockchain projects offer their solutions to the Trilemma. Some prioritize scalability, sacrificing decentralization. Others focus on decentralization, accepting limitations in scalability and speed. Core blockchain aims for a delicate balance between all three.

## Inception of The Core Project

The origin of Core is essentially one of those rare instances where a debate among friends led to something productive and by productive we mean a thriving blockchain ecosystem. According to an official tweet from Core DAO: Two friends, one an ETH Maxi and another a Bitcoin Maxi were debating the pros and cons of the two blockchains and this sparked the idea to create a blockchain that will carry the best of both chains.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXfWCF3hbFWpKzEE-XiQJQ64gI-9eSG6S93PeCf7zlMJnD-_WARR3PrZD2_P1AoHDGghzknopEr7xOmqCo9U4Ea-GiBA2qACVwnRzuuyIy-K8gpRAuy9e8zi0zNjB8yxwyQSrr-J-dMpCK211rZaGHdUB84?key=vtLTtJHs5MQqzL6kDiBltQ](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%201%20images/L4%20P3.webp?raw=true)

Now, in case you are wondering what a Maxi is, they are essentially hardcore supporters of a particular protocol.

Core is a community-driven initiative, developed and maintained by a global network of contributors, many of whom prefer to remain anonymous, as is quite common in the web3 space.

The Core team released the initial testnet on July 29, 2022, and almost 6 months later, on January 14, 2023, the Core mainnet was launched.

Core's codebase is built upon a heavily modified and enhanced version of [Geth](https://geth.ethereum.org/), the Go-language-based implementation of Ethereum. It has leveraged various performance improvements inspired by projects like BNB Smart Chain (BSC) to achieve high throughput and reduce transaction costs.

However, Core differentiates itself significantly through its unique consensus mechanism called Satoshi Plus. This algorithm combines Bitcoin's [Proof of Work (PoW)](https://ethereum.org/en/developers/docs/consensus-mechanisms/pow/) with a [Delegated Proof of Stake (DPoS)](https://en.bitcoin.it/wiki/Delegated_proof_of_stake) system and Non-custodial BTC Staking. Through this, it addresses the scalability and energy concerns of traditional PoW while preserving the decentralization that is fundamental to blockchain technology.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXchmewK1XreTp_2LF7XB6naC3yflCYQGAsVqyuScPKceYufbbsiraivpbtk-04H3ycGXcbXQmpjilxciw64Bdb5LOP65_dUzpZ7TR-FVzBfjiclu5ifq1J6X9Ue507jB872AjuturXbcvPmS4TJ9Cq_8JZf?key=vtLTtJHs5MQqzL6kDiBltQ](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%201%20images/L4%20P4.webp?raw=true)

Furthermore, Core introduces a novel hybrid score system, which factors in delegated Bitcoin hash power (PoW), delegated stake in the form of CORE tokens (DPoS) and delegated BTC through the Non Custodial BTCs staked, to determine validator selection and reward distribution. This approach aims to create a more equitable and accessible validator ecosystem. But more on that later.

For now, just understand that Core isn't just a remix of existing ideas. It brings forth its unique blend of innovations and ideas that takes it much closer to cracking the blockchain trilemma. And makes Core stand out from the rest of the Blockchain crowd.

## How does Core Tries To Solve The Trilemma

Core's innovative Satoshi Plus consensus mechanism directly addresses the blockchain trilemma, achieving an unprecedented balance of security, scalability, and decentralization. By integrating Bitcoin's robust Proof of Work security model with the efficiency of Delegated Proof of Stake, and the innovative Non-Custodial BTC Staking mechanism, Core ensures both a high level of protection against attacks and rapid transaction processing. This unique combination not only enhances the overall security and efficiency of the network but also empowers Bitcoin holders to actively participate in the Core ecosystem while retaining full control of their assets.

Core's compatibility with the Ethereum Virtual Machine (EVM) further enhances scalability by allowing for the integration of Ethereum's cutting-edge scaling solutions. Moreover, the unique hybrid score system for validator selection, which combines Bitcoin hash power and CORE/BTC token staked, fosters a more equitable and decentralized network, preventing the concentration of power among wealthy stakeholders. This commitment to decentralization is further solidified by Core DAO's community-driven governance model, empowering CORE token holders to actively participate in decision-making processes.

## Problems Addressed by the Core Blockchain

With all this fancy tech under the hood, Core aims to tackle major issues in the blockchain space and redefine interaction with this technology:

- **Scalability and Security:** Satoshi Plus balances scalability, security, and decentralization, allowing faster and cheaper transactions without sacrificing security.
- **Decentralized Governance and Community Participation:** Core emphasizes community involvement in decision-making processes. Through staking and voting mechanisms, individuals can actively participate in shaping the future of the network.
- **Permissionless Innovation:** Core is open to everyone. Bitcoin holders can earn passive income by staking their BTC, while developers can build innovative dApps on the platform. This creates a vibrant and inclusive ecosystem that benefits all participants.
- **Unlocking Bitcoin's Potential:** Core enhances Bitcoin's functionality by providing additional revenue streams for Bitcoin miners, maximizing Bitcoin's utility and value.

## Wrap Up

Alright! We've covered a ton about the Core’s history and its innovative approach to the blockchain trilemma. There's still much more to explore. In the coming lessons, we'll delve deeper into Core's inner workings, including its consensus mechanism, governance model, and the roles of different participants. Buckle up and get ready to discover the exciting world of Core!
