# Deep Dive into Satoshi Plus Consensus

Well..Well..Well, look at you, all fired up and ready to roll! It feels like just yesterday we were starting this Core blockchain journey together, and now you're diving deep into the nitty-gritty of the network. Good on ya! But hey, before we get too carried away, let's make sure we're all on the same page with the basics. Take a breather, maybe revisit our last lessons, and refresh your memory on the Core network's different moving parts. It's all about building that solid foundation!

All good? Awesome! Then let's dive right in and discuss one of the Core elements of the Core Network (Get it!)

## Understanding Satoshi Plus Consensus Mechanism

Satoshi Plus is a cutting-edge consensus mechanism, think of it like the engine that drives the Core ecosystem. What makes it so special? It's a hybrid, blending the robust security of Bitcoin's Proof of Work (PoW) with the agility and community spirit of Delegated Proof of Stake (DPoS) and the innovative Non-Custodial BTC Staking. This unique approach creates a blockchain network that's more secure, decentralized, and scalable, setting a new standard for the crypto world.

**The Players in Satoshi Plus: A Team Effort**

Satoshi Plus isn't just a technical concept; it's a collaborative effort involving different groups of participants working together to keep the Core blockchain running smoothly and securely. Now, we have already introduced these components before, Here we will see how they contribute to the functioning of the consensus mechanism:

- **Validators:** Think of validators as the elected officials of the Core community. They're responsible for processing transactions and adding new blocks to the blockchain. They're chosen based on their reliability and commitment to the network's security, and they have to put up a deposit of CORE tokens (the blockchain's native currency) to show they're serious about their job.
- **Delegators:** CORE and Bitcoin holders are the voters in this system. They show their support for validators by "delegating" their tokens to them. The more tokens a validator has staked with them, the more likely they are to be elected. It's a win-win: delegators get a share of the rewards earned by the validator, and the validators get the support they need to secure the network.
- **Bitcoin Miners:** Bitcoin miners, who are already busy securing the Bitcoin network, can also get involved in Satoshi Plus. Through Delegated Proof of Work (DPoW), they can lend their computing power to Core validators, making the Core network even more secure. In return, they get rewarded with CORE token.
- **Relayers:** These participants ensure smooth communication between the Bitcoin and Core blockchain. They're essential for making sure the DPoW process works seamlessly.
- **Verifiers:** Verifiers act as the watchdogs of the network. They monitor validators to ensure compliance with network rules and report any misbehavior, maintaining the network's integrity.

![comment](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L5%20P1.webp?raw=true)

## How DPoW Works in Satoshi Plus

Core leverages the Delegated Proof of Work (DPoW) through its consensus mechanism for creating a powerful synergy between the Bitcoin and Core networks. Bitcoin miners, who are already securing the Bitcoin blockchain with their immense computing power (hash power), can extend their influence to the Core network by signalling their support for specific validators. This is achieved by including a special endorsement message in the coinbase transaction of the Bitcoin blocks they mine. The coinbase transaction is essentially the first transaction in a bitcoin block and the message embedded in that transaction acts as a vote of confidence for the chosen validator.

Relayers on the Core blockchain continuously monitor the Bitcoin blockchain for these endorsements. When they detect an endorsement, they submit proof of this endorsement to the Core blockchain. This proof is then used to determine the likelihood of a validator being selected to create new blocks on the Core blockchain. The more endorsements a validator receives from Bitcoin miners, the higher their chances of being selected.

![comment](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L5%20P2.webp?raw=true)

This system not only enhances Core's security by leveraging Bitcoin's established hash power but also provides Bitcoin miners with an additional source of income in the form of CORE tokens. It's a mutually beneficial relationship that strengthens both networks and fosters a collaborative environment for the growth of the broader blockchain ecosystem.

## How DPoS Works in Satoshi Plus

DPoS is all about giving the community a voice and control over the Core network. CORE token holders get to choose who they want to run the network by staking their tokens with their preferred validators. This is like voting in an election – the more votes (or staked tokens) a validator gets, the more likely they are to be elected to the active validator set.

![comment](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L5%20P3.webp?raw=true)

**Benefits of DPoS**

This staking mechanism gives token holders a direct say in the network's decision-making and aligns the interests of validators with those of the community. Validators are motivated to act honestly and maintain the network's health to attract more stakes and secure their position in the active set. This creates a virtuous cycle of accountability, transparency, and trust, where the community actively participates in shaping the future of the Core network.

## Understanding Non-Custodial BTC Staking

One of the most innovative aspects of Satoshi Plus is the Non-Custodial Bitcoin (BTC) Staking. It allows Bitcoin holders to join the Core Ecosystem without giving up control of their precious BTC. Instead of handing over their Bitcoin to a third party, users leverage a Bitcoin-native cryptographic feature called "absolute time locks." This is like setting a timer on your Bitcoin, locking it up for a specific period to prove your commitment to the Core network. This time-locked transaction doesn't move the BTC from your wallet but creates a representation of it on the Core blockchain. This representation, though not a separate token like wrapped Bitcoin on other chains, acts as your ticket to participate in Core's decision-making process and earn rewards in CORE tokens.

![comment](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L5%20P4.webp?raw=true)

The beauty of this system is threefold:

- **Security and Decentralization:** By attracting both Core and Bitcoin communities to participate in staking and validation, the network becomes more secure and resistant to centralization.
- **Passive Income for Bitcoin Holders:** Bitcoin holders can earn rewards by staking their BTC on Core, providing a new avenue for passive income without sacrificing ownership of their assets.
- **Inclusivity and Diversity:** By lowering the barriers to entry for both BTC and Core token holders and miners from different blockchains, Core creates a more diverse and inclusive ecosystem.

It's a win-win-win scenario that showcases the power of blockchain innovation and opens up exciting new possibilities for both Bitcoin and the Core network.

### What is the Hybrid Score

The hybrid score is the ultimate report card for Core validators. It's a comprehensive evaluation that takes into account three key factors:

1. **Staked CORE:** This reflects the trust and support from CORE token holders, showing which validators the community believes in.
2. **Staked Bitcoin:** This shows the broader cryptocurrency community's faith in the Core network and its validators.
3. **Delegated Hash Power:** This measures the security contribution from Bitcoin miners, indicating the level of support from the Bitcoin network.

Think of the hybrid score as a combination of popularity, trustworthiness, and security contributions. The validators with the highest scores get the privilege of securing the network and earning rewards, ensuring that the most capable and reliable individuals are in charge. In the next chapter, we will dive deep and see how the hybrid score is actually calculated.

## How Satoshi plus consensus ensures security, decentralization, and scalability

Through its innovative Satoshi Plus consensus mechanism, Core aims to tackle the blockchain trilemma – the challenge of achieving scalability, security, and decentralization simultaneously –. This hybrid approach combines Bitcoin's battle-tested Proof of Work (PoW) with a Delegated Proof of Stake (DPoS) system and the novel Non-Custodial BTC Staking feature.

**Security:**

- **Bitcoin-Level Protection:** Core inherits the unparalleled security of Bitcoin's Proof of Work (PoW) system, widely considered the gold standard in blockchain security. This provides Core with robust protection against attacks and ensures the integrity of its data.
- **Double the Defense:** Bitcoin miners actively contribute to Core's security by delegating their hash power to Core validators. This creates a double layer of security, making it exponentially harder for malicious actors to disrupt the network.

**Scalability:**

- **Efficient Transaction Processing:** Core leverages Delegated Proof of Stake (DPoS) to achieve superior scalability compared to traditional Proof of Work (PoW) blockchains. With DPoS, a select group of validators efficiently processes transactions, resulting in faster block times and higher throughput. This enables Core to support a growing ecosystem of decentralized applications while maintaining optimal performance, ensuring seamless user experiences even as demand increases.
- **Ethereum-Powered Scaling:** Core Chain's full compatibility with the Ethereum Virtual Machine (EVM) opens the door to leveraging Ethereum's extensive array of scaling solutions.

**Decentralization:**

- **Leveling the Playing Field:** Core's hybrid score system combines delegated Bitcoin hash power (PoW) and delegated CORE and BTC stake (DPoS) to determine validator selection. This approach ensures that validator power is not solely concentrated in the hands of the wealthiest stakeholders, creating a more equitable and decentralized network where smaller players can actively participate.
- **Community-Driven Decision Making:** Core DAO embraces a community-driven governance model, empowering CORE token holders to propose and vote on changes to the network. This ensures that the network's development is guided by the collective will of the community, preventing any single entity from exerting undue influence.

## Wrap up

Alright, team, we've just scratched the surface of the Core network and its revolutionary Satoshi Plus consensus. We've met the key players and seen how they work together to keep the blockchain humming. But the real magic lies in how these players collaborate to make decisions and secure the network. Ever wondered how the validators, the ones in charge of processing transactions and adding blocks to the chain, are actually chosen? Get ready, because in the next chapter, we'll be taking an in-depth look into all that! So, Let's go!
