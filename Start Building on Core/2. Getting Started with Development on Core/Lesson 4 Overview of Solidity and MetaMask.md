# Overview of Solidity and MetaMask

Welcome back devs! If you want to take full advantage of everything that Core has to offer and build some dope apps on Core, you’ll need to be able to interact with it. Just like how we’d use English or any other spoken language to chat and share our thoughts, we'll be using Solidity to code and interact with the Core blockchain.

Think of Solidity as the language that allows you to give instructions to the blockchain. But, to send those instructions and see the responses, you need a way to communicate with the blockchain in a secure and user-friendly manner. This is where MetaMask comes in.

[MetaMask](https://metamask.io/) is like your personal passport in the web3 world. Just like you need a passport to travel and prove your identity in different countries, MetaMask serves as your identity in the decentralized web. It allows you to securely store your crypto assets, manage your identities, and interact with decentralized applications (dApps) seamlessly.

In this lesson, we'll give you a solid overview of Solidity and show you how to set up your own MetaMask Wallet. With MetaMask, you'll be able to connect to the Core blockchain, deploy your smart contracts, and manage your crypto transactions with ease. So let's dive in and get started.

## What is Solidity?

Solidity is an object-oriented, high-level programming language used for writing smart contracts on EVM-compatible blockchains. It is a tool to generate machine-level code to execute on EVM. The solidity compiler takes the high-level code and breaks it down into simpler instructions. It is influenced by popular programming languages like C++, Python, and JavaScript.

Solidity is the first choice of development as it is specifically designed for creating smart contracts and interacting with EVM-compatible blockchains, like Core blockchain. This pretty much justifies the [$158 billion dollars of Total Value Locked (TVL)](https://defillama.com/languages) of Solidity language as of July 2024.

![img1](https://lh7-us.googleusercontent.com/docsz/AD_4nXfO8w3bjDcTRZr1iZKEOQ1Ce-vGvwPiDRrQs5sH8H1kk-X02_2sU13TMTknSxJfrq7GLpBcMrRllhfLy5474DImc44IPaWqSwiGrSHSjja7P4n32jIoHboY3kbpskSg9z1l5Lt4f_j5EbMQQsN4UO111Us?key=_zOhLuY_gIL2THtHu9ZzcA)

### Why use Solidity?

- **Develop dApps**: Solidity is primarily used to create smart contracts, which are automated programs that enforce and verify agreements on the blockchain, essential for building secure, decentralized applications (dApps).
- **Immutable Contracts**: Smart contracts are transparent, tamper-proof, and can't be altered once deployed on the blockchain.
- **EVM Compatibility**: The Ethereum Virtual Machine (EVM) supports Solidity, making it a preferred choice for developers building on EVM-compatible blockchains like Core.
- **Versatile Use Cases**: Solidity enables a wide array of decentralized applications, from financial tools like lending platforms and decentralized exchanges, to creative pursuits like digital art (NFTs) and gaming, to governance systems like voting mechanisms and autonomous organizations.
- **Active Community and Support**: Benefit from a large, active community of developers, extensive documentation, and ongoing support for learning and troubleshooting.
- **Comprehensive Development Tools**: Leverage a variety of development tools and frameworks that integrate seamlessly with Solidity, making the development process more efficient and robust.

### Key features

Solidity boasts a range of powerful features that make it ideal for creating smart contracts. Here are some of its standout features:

- **Object-Oriented**: Solidity is designed as an object-oriented programming language.
- **Supports Inheritance and Libraries**: You can reuse and extend your code through inheritance and libraries.
- **Function Modifiers and Events**: Solidity includes function modifiers and events to enhance functionality and track contract activity.
- **Built-In Data Structures**: It comes with built-in data structures and types such as mappings and arrays.
- **Open-Source**: Solidity is an open-source language, allowing for continuous improvement and community contributions.
- **Runs on Ethereum Virtual Machine (EVM)**: Solidity is executed on the Ethereum Virtual Machine, ensuring compatibility and security.

## Core and Solidity

Core isn't just a blockchain, it's a developer's playground. They are constantly pushing boundaries to make building their platform smooth and efficient.

![img2](https://lh7-us.googleusercontent.com/docsz/AD_4nXcKFVk8wwL7Qf5etKZM__gaP3xwZsrlp7jO7wpCdAq11imKYCHQyy4hLPsRhQo1eROc--EvpNeAARJnwP2RCin5SxvUs55WlJHXWJe5pZDU8SBQ_byTdeg22XAopiRz1JBwLUnyY2bDBgndVxD0HD9MazRh?key=_zOhLuY_gIL2THtHu9ZzcA)

To ensure consistency and compatibility, Core supports all Solidity versions and EVM versions, however for solidity v0.8.19 and above it currently provides support using the Paris EVM. Don't fret, We'll guide you through the entire configuration process in the next lesson, making it easy for you to set up your project

So, that's the deal with Core and Solidity! Now that you know they work well together, let's jump into setting up your own MetaMask wallet.

## Creating your own MetaMask wallet

Your MetaMask wallet is your key to the web3 world. With your MetaMask account, you can interact or communicate with the blockchain seamlessly. It's your digital wallet for storing, swapping, and buying cryptocurrencies, tokens, NFTs, and more.

MetaMask is available as a stand-alone mobile app and a Chrome browser extension. We'll be using the Chrome extension, as most of us will be developing in a desktop environment.

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXdXZeJoNLg67PmBOPDJ5XNHq_AbakC_YNY1OCBKmf3xzKMDJ6uVSURy2YTqExeaPFdxXld33feOxOuJkqoIb1GkS83EZgtthIFGYhTH2_6OMInhozVUqhMbhmRX1f71I7ZqOOvmThXGoMxAn3QhOe40ttL3?key=_zOhLuY_gIL2THtHu9ZzcA)

Here are the installation steps:

- Go to [MetaMask.io](https://metamask.io/).
- Click "Download for Chrome" and install the Chrome extension.
- Agree to the terms of use and conditions.
- Set up your secure password.
- Secure your 12-word recovery phrase properly and never share it with anyone.

Write down your recovery phrase and store it safely. If you lose it, there's no way to recover your account, so be very mindful.

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXdq7pTtU6N0tIVijNJBtohtXspUvgF6idCwPcZSR7Mtq1yZ0Z64uDlfhe-GbZ2xi36ErD6Au-5vGPmCKl5NaoLF5Vb44cTnaDgX2g7V1Cz9ssEi6NZhz2vknHVjoEaf3bDc22VOcA-YkvqQ7BjHzH4EoHw?key=_zOhLuY_gIL2THtHu9ZzcA)

Congrats🎉! your account has been created and now we will need to get two important pieces of data related to our account for us to publish our dApp.

1. Public Address
2. Private Key

To extract your public address and private key from the MetaMask Chrome extension, follow these steps:

- Open the MetaMask extension in your browser.
- Click on the three dots in the upper right corner of your account card.
- Select "Account details" from the dropdown menu.
- You'll see your **public address** displayed at the top. Copy it for later use.
- To export your **private key**, click on "Show private key."
- Enter your MetaMask password to confirm.
- Click and hold the button to reveal your private key.
- Copy your private key and store it securely. Remember, never share your private key with anyone.

![img](https://lh7-us.googleusercontent.com/docsz/AD_4nXckWr5zyMBsp1Stvkb0nctr1X-O12DEfv4-mdXUHoZpr0NdSnPR5dpYqT80C1tJiHsAbHo1xrcxo5T13rKon8sM-KeyAVPA5NIQ-CYO4U6_f6vo5CbC-ic4pvqmxGHyNVarzVQjEZam3Jwn5Ur1xzu-fEZO?key=_zOhLuY_gIL2THtHu9ZzcA)

We suggest keeping these pieces of information handy as we'll need them for upcoming lessons. Your MetaMask wallet serves as your gateway to the web3 world, enabling seamless interaction with the blockchain. Remember to safeguard your public address and private key securely, as they are essential for publishing your dApp and managing your digital assets.

## That’s a Wrap

Awesome job Guys 💪! In this lesson, we dived into the basics of Solidity and its key features, explored why it's the go-to language for developing on the Core, and set up our MetaMask wallet, your gateway to the web3 world. We also learned how to extract your public address and private key, which are essential for publishing your dApp.

Now that we have a solid foundation and our tools ready, we're all set to start setting up our development environment in the next lesson so that we are on our way to building our Lending dApp. Cheerio ✌️