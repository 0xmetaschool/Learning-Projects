# Infrastructure of Core Blockchain

The world of Decentralized Finance (DeFi) offers exciting possibilities, but navigating it can get tricky. Core simplifies your journey with innovative tools. In this lesson, we will learn about some pioneering DeFi Solutions for Bitcoin offered by Core. We'll be exploring the new stCORE token for liquid staking, coreBTC which is a wrapped version of Bitcoin native to Core, and the Core Bridge that connects Core to other blockchains. We'll also delve into the Core Scan, Core’s block explorer, for transaction analysis and the Core Scan API for programmatic access.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXcRiNs0x5K2N6G7NW3ewLLqUKWsYvC2adfvDmMz2ScLWIEru4lZFjqYMh3F1IYOsOVeql3wTSeZ1hFSSg4VsRkaNL53qZTnmoqFpNL08a0xIVmHnbJRnE7xM53ZzwGECW9Y_IDCY1W6AmNKRxrnBS2asTNQ?key=95ak5YnMLrnhV2lMqJWnXw](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L7%20P1.webp?raw=true)

But wait, there’s more! The Core team is on a mission to bring billions of people into the web3 world. To make crypto super accessible for everyone, they’ve crafted the [Element wallet](https://www.elementwallet.com/), a game-changer that's both an on-chain messenger and a peer-to-peer payments app. Sounds exciting, right?

Also, the Core team partnered with the Satoshi App to bring you free $CORE airdrops and make you an early adopter of the Core blockchain.

Don’t worry, we’re going to explore all the juicy details in just a bit. Stay tuned!

## Types of Nodes

Before we dive into the nitty-gritty of Core's infrastructure, let's get a good handle on the backbone of the whole system: the nodes. These aren't your everyday computers – they're specialized workhorses running software that keeps the Core blockchain humming. They're like the unsung heroes, working together to ensure everything runs smoothly, securely, and truthfully. Understanding these different types of nodes is like getting a backstage pass to the inner workings of Core.

So, let's lift the curtain and take a closer look at the main players that make up the Core ecosystem:

- **Full Nodes:** These are the backbone of the Core network, maintaining a complete copy of the blockchain. They validate transactions, ensure the integrity of the blockchain, and relay information across the network. There are two types of full nodes:
    - **Normal Full Node:** This node downloads and verifies all blocks and transactions, ensuring the accuracy and validity of the blockchain data. However, it doesn't provide any additional services beyond that.
    - **RPC Full Node:** In addition to the functions of a normal full node, an RPC (Remote Procedure Call) full node provides an interface for external applications (like wallets or explorers) to interact with the blockchain. It allows users to query data, send transactions, and access other blockchain functionalities.
- **Validator Nodes:** These are special nodes that are elected to participate in the Satoshi Plus consensus mechanism. Their primary role is to validate transactions, create new blocks, and maintain the network's security and integrity. To become a validator, nodes must stake a significant amount of CORE tokens and meet certain technical requirements. Validators are incentivized to act honestly through block rewards and transaction fees.
- **Archive Nodes:** Archive nodes are similar to full nodes, but they store the entire history of the blockchain's state, including all past transactions and smart contract data. This makes them invaluable for applications that require access to historical data, such as block explorers or analytics tools.
- **Snapshot Nodes:** Snapshot nodes store the current state of the blockchain, but not the entire history. They are designed to be more lightweight than full nodes or archive nodes, making them easier to set up and run. Snapshot nodes are ideal for users who need to interact with the blockchain but don't require access to historical data.

## stCORE

Staking CORE or stCORE tokens is a LST( Liquid Staking Token ), designed to enhance the utility of CORE tokens and streamline the staking process. While traditional staking contributes to network security, it often restricts token liquidity, hindering users' ability to participate in various DeFi protocols.

stCORE addresses this limitation by creating a liquid staking derivative. By minting stCORE, users can effectively lock their CORE tokens for staking purposes while simultaneously receiving a representation of their staked assets. This representation, stCORE, functions as a tradable token within the DeFi ecosystem, enabling users to leverage their staked CORE for additional opportunities without sacrificing staking rewards.

It’s quite easy to get started with liquid staking with stCORE. You can head out to the [Core Liquid Staking Platform](https://stake.coredao.org/stcore), connect your wallet and then either mint stCORE using CORE tokens or redeem CORE using stCORE. It’s as easy as that.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXftwRqhElSnY5EGcDxbFPYzPmEnimR-hYN71kOMIRv-wRrhvRXIDS1qTd0t1l9l8ZuhSy3yRES_0mW91fJp4iPvgJnN69SreKMGE-ZjjT5JfA7q110VqjHoAPU4j9_lgn9o7XVZFTRJdcr1OHiK0YyZJSo?key=95ak5YnMLrnhV2lMqJWnXw](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L7%20P2.webp?raw=true)

## coreBTC

coreBTC unlocks the power of DeFi for your Bitcoin (BTC) holdings. Unlike traditional Bitcoin, coreBTC is a **native wrapped BTC** on Core, meaning it maintains a 1:1 exchange rate with BTC. This secure and trustless mechanism, powered by a decentralized network, allows you to seamlessly integrate your Bitcoin into the exciting world of DeFi.

**Benefits of coreBTC:**

- **Effortless DeFi access:** Use coreBTC to participate in DeFi applications on Core blockchain, unlocking opportunities previously unavailable to Bitcoin holders.
- **1:1 BTC peg:** coreBTC maintains a stable 1:1 value with your underlying Bitcoin, ensuring a secure and transparent representation.
- **Decentralized and permissionless:** No central authority controls coreBTC, fostering a secure and trustless environment.

You can head out to the [coreBTC Website](https://bridge.coredao.org/coreBTC), connect your Unisat Wallet, and then either convert Bitcoin (BTC) to coreBTC or vice-versa easily.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXdJaI5o46K885jq5IPHwldDNrqB1VfawD8SYCg6PMt8e_3Ro7lBQRrssgtPv7KQNn9qyDTdltBfzDkiVdAc0L7QtfCNIYWvxf5GJrZcFSUltBwGF8ZfxOIIKg72x4FZh7dAOrxrcqqSHtnw9OxV2-iPblXg?key=95ak5YnMLrnhV2lMqJWnXw](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L7%20P3.webp?raw=true)

## Core Bridge

[Core bridge](https://bridge.coredao.org/bridge) facilitates bi-directional transfer of prominent tokens between Core and other blockchains like Ethereum, BNB Chain, Avalanche, Polygon, Arbitrum, and Optimism.

Benefits of the Core Bridge:

- **Seamless Multi-Chain Connectivity:** Effortlessly move your assets between Core and blockchains like Ethereum, BNB Chain, Avalanche, Polygon, Arbitrum, and Optimism. This flexibility empowers you to explore DeFi opportunities across various ecosystems.
- **Enhanced Asset Management:** The Core Bridge simplifies asset management within the multi-chain landscape. You can effortlessly transfer your tokens, streamlining your DeFi experience without disruptions.
- **Powered by LayerZero Protocol:** The Core Bridge leverages the advanced security and efficiency of the LayerZero Protocol. This ensures fast and secure transactions across different blockchains, adhering to a unified standard.

Imagine having unrestricted access to the vast potential of DeFi, regardless of the underlying blockchain. The Core Bridge makes this vision a reality. You can head onto [Core Bridge](https://bridge.coredao.org/bridge) and then just select the network you want to transfer tokens from to Core or vice versa.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXcCKvvaBAfRbzQQ1xqF-D6Z_-Nzsh1qwSf1_POUtQpCJ7tKtTR1SK_TbD7J1e2zOYAdqImllLEVtjojvaAr4L9zl_nqe2yotZ1-RAxYbz17eUv5uEAOPqP_Kbk2FXshDSdJe5Jvz50qytruysXAssJ0ij0?key=95ak5YnMLrnhV2lMqJWnXw](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L7%20P4.webp?raw=true)

## Core Scan

[Core Scan](http://scan.coredao.org/) empowers you to search transactions, verify confirmations (how many times a transaction is validated), and even analyze validator performance – all to ensure the smooth operation of the network.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXfXyM6gYl5IaDbAUzSK4tcC9-1sdRBBnzecFBECseSmSbS9E0gcMqLLgEMQge_yYW6koTw5eKGbT_ORXkl7ZT7_lIPHAiFEMx7lUbb_44Aw9oQxRIifqdxVjR9B3FkM7PmNGKuuWhWZ3xbzD-qZrLDTW9k?key=95ak5YnMLrnhV2lMqJWnXw](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L7%20P5.webp?raw=true)

Following are some of its features :

- **Surgical Transaction Search:** Effortlessly locate specific transactions by hash, block number, or wallet address. No more sifting through endless data!
- **Confirmation Checkup:** Ensure your transactions are secure by verifying the number of confirmations. More confirmations mean a higher level of security.
- **Block Deep Dives:** Go beyond the surface and analyze individual blocks. Explore details like block hash, timestamps, validator information, and included transactions.
- **Validator Watchdog:** Monitor the performance of individual validators. Track metrics like block production rate, uptime, and self-delegation to identify reliable validators.
- **Network Pulse Check:** Gain a real-time understanding of Core blockhain's health. See live data on total transactions, active validators, circulating supply, and other essential network metrics.

## Core scan API

The Core Scan Open API empowers developers to seamlessly integrate Core blockchain data and functionalities into their applications. This community-driven initiative unlocks a wealth of possibilities for building innovative solutions within the Core ecosystem.

To get started,

- Head over to the [Account Registration](https://scan.coredao.org/register) page
- Provide username, email, and password for your account and create your account.
- Verify your account using the confirmation link sent to your email.
- Now you can create your API key for interacting with either the Mainnet or Testnet.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXddATT7ZCe5f6PfvydRGyC7YiCHyhcq2imNjap9GxZpHLZvX22T6HVi306Rmx3F-OfoTOAxGUSK3Lwta96WEIJc2spDxyIytLWi2htcSDIZwXUObyQXL0OzbWsnl-1ryas-aq7_lcjRD9JoOgqmasIl6tXV?key=95ak5YnMLrnhV2lMqJWnXw](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L7%20P6.webp?raw=true)

All endpoints and parameter formatting are the same on Mainnet and Testnet, you are only required to change the relevant API endpoint URL as follows.

| Network | Endpoint URL | Documentation |
| --- | --- | --- |
| Mainnet | https://openapi.coredao.org/api | https://docs.coredao.org/api |
| Testnet | https://api.test.btcs.network/api | https://docs.coredao.org/api |

Now we can easily fetch Information about deployed smart contracts, Users' CORE balances and Detailed transaction information using our endpoints.

## Core - Native Wallet & Messenger (Element)

[Element](https://www.elementwallet.com/) is your ticket to a simple, safe, and fun Web3 mobile interface, specially designed for the Core blockchain network. Element makes your Web3 experience a breeze by incorporating easy-to-use touchpoints and ditching those complicated old interfaces.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXeS_6M9x-osA9A-99wb3-N5O3zsqXkaOz5f8ZUf7lAHeBLitSCUriAeiuxDgtNvUDnDMJ5jqQ1c_X9fVpjTEXVhZBMmvmWGuaj8b2MvwJj6Tt09-Z2gH1Ph3I2qOPWdfKD6uE2W8ffHss81duhJk9cTQFI?key=95ak5YnMLrnhV2lMqJWnXw](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L7%20P8.webp?raw=true)

Teaming up with Core, Element lets you seamlessly navigate and interact with the Core blockchain. Launching in 2023 on iOS and Android, Element isn't just an app—it's set to become the ultimate platform for your digital life.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXdoNTWObGNCUe6Ux5AgXO1ln2UtA1oKR5YEmvRegcHm5kv0C3iW2LqlFr52JD-6jUvmtX9c6VwG8v5U0pLJ-U0U7exE7DL961tDsAq24BT8Eq9hmTE0FlH0k6GEoMRvAguwPB1DDZtDtWLu9rbXMrqUMQ4f?key=95ak5YnMLrnhV2lMqJWnXw](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L7%20P9.webp?raw=true)

Element is also a game-changer in messaging! With rock-solid end-to-end encryption and blockchain magic, your chats are private and unalterable. Unlike cloud-based apps, Element puts you in control. Forget the fuss with WhatsApp or Telegram; Element is all about privacy from the start.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXcFjPW9cyhGXMvDBad6OBVGHPRBv0eCI4jAG8vm0pc9sEhmk1UFLyz7f67LXVyBq0HS53UAr6yEMO1Y9tHwLakPvyhL6he3UuuNRgJXnm_vsp-8cLWC6s500Eu8lRABNtml1j0jli3CfuYoSzldiB9ETeQY?key=95ak5YnMLrnhV2lMqJWnXw](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L7%20P10.webp?raw=true)

## Satoshi App

![https://lh7-us.googleusercontent.com/docsz/AD_4nXexlcrShHia22TMLm6XifHObhlnnX5FxQC_EsBjQS01g3VHfnobbhZosk7UUt-hNgimqYJEoJrzcWET82ayh-mo9_sGokKKJBOv3moX8enh_FlObiiU9UDyTNIA7ZPvYTjY2Wbggd597S9ZMu_BrUwP7R0?key=95ak5YnMLrnhV2lMqJWnXw](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L7%20P11.webp?raw=true)

Satoshi was a trailblazer, that introduced the Core blockchain to over 11 million users, driven by thorough research and unwavering belief in its potential. The Satoshi app not only airdrops CORE tokens but also allows you (the users) to mine the CORE tokens using the mobile application.

In April 2024, CORE, the inaugural project on the Satoshi APP, skyrocketed with an unbelievable 400+% surge in its price, pushing its market cap past a jaw-dropping $3.2+ billion! This incredible leap isn't just a victory for CORE fans; it's a shining symbol of Satoshi App's core values. Here’s the chart image from the CoinMarketCap.

![https://lh7-us.googleusercontent.com/docsz/AD_4nXfqMPOQwimOmmvYldJwTjOtV3GmPHx1hIWlA7VoCNs6RKQW9TfnnQQwXHPOJxH7GbfVbOQyBogg7pntGYA0Z3mhhcnIRsdB0DRV4ut5uvHFP24-D2tI3Qn4kMa_cIe1h0uM-LZroF1P-0Q2Eloafqmg9B4?key=95ak5YnMLrnhV2lMqJWnXw](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assets-for-core-c1/Section%202%20Images/L7%20P12.webp?raw=true)

This epic tale of success isn't just for Satoshi to celebrate—it's shared with over 2 million users who placed their trust in CORE and joined them on this thrilling journey.

## Wrap Up

From staking and wrapped assets to seamless transfers and network insights, Core equips you with multiple tools to fully utilize what Core blockchain has to offer.

Next up, we will explore different platforms where you can stake your CORE tokens and not only this, we will explore some additional resources that will help you get on board with the Core blockchain with ease.
