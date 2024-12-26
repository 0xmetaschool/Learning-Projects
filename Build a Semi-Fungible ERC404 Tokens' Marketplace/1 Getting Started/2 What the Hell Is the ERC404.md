# What the Hell Is the ERC404?

Welcome back! Today, we are going to explore the curious case of the ERC404 token. Let's dive into what it is, how it works, and its impact on the real world.

## Let's revise what ERC20 and ERC721 tokens are

First, let’s start by discussing two main token standards on the Ethereum blockchain: ERC20 and ERC721 tokens.

ERC20 tokens are fungible tokens that function like traditional currency. They are the equivalent of a dollar in the Ethereum ecosystem that you can hold in your digital wallet and are commonly used as a gas price for everyday transactions.

On the other hand, ERC721 tokens are non-fungible tokens (NFTs) that are highly valued based on their uniqueness and collectible value. Each NFT is one-of-a-kind and cannot be exchanged for another NFT.

While these tokens are very different, they can be bought and sold with each other. However, you can only buy entire NFTs with fungible tokens, as there is no way to buy only a portion of an NFT.

This is where the ERC404 token comes in. What is it, you may ask? Stay tuned!

## So, what the hell is the ERC404 token?

The ERC404 token is a unique token that combines both ERC20 and ERC721 token features. It aims to blend the best features of both token standards and propose innovation to the NFTs. With this innovation, multiple wallets can own shares of a single NFT piece from a collection.

![intro-1.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_erc404/1%20Getting%20Started/2%20What%20the%20Hell%20Is%20the%20ERC404/intro-1.webp?raw=true)

This token is experimental and can be either a fungible or non-fungible token based on its implementation. Let me explain this with multiple examples.

### Example #1

If you decide to create a fungible token using the ERC404 token standard, it will be interchangeable with other tokens of the same kind without any loss of value. Once the token has been used or redeemed, it can be transformed into an NFT, which possesses unique and collectible qualities. 

Think of it like this — there is a coin from the 20BC century. In the 20BC century, it was used to exchange goodies, but now it is worth a lot more and stored in a museum for everyone to look at and get inspired.

### Example #2

On the other hand, if you create an NFT using the ERC404 token standard, it can be divided into multiple smaller units that can be traded as fungible tokens. When the divided units are recombined, it becomes an NFT again.

Think of it like this — there is a unique digital artwork that can be divided into pieces, where an individual token represents each piece. Each piece can be co-owned by multiple people, and each individual can trade their piece just like any other tradable asset. 

This approach makes it easier for NFTs to reach a wider audience and increase their liquidity.

Isn't this exciting?

Now, let’s dive into a bit more of the technical aspects of the ERC404 token standard.

## How does the ERC404 token standard work?

ERC404 allows fractional ownership by linking the tokens (every issued token) with a specific NFT. This type of linking allows NFT to have multiple owners based on the share of tokens they will have. Each NFT can have a base unit that defines the minimum amount of linked tokens that can be transferred, held, or exchanged with anyone. This enables the widespread distribution of a single NFT, increasing the liquidity of both the NFT and the token.

Let’s take an example to understand this better.

### Example

Consider an NFT named "Artistic Ape" that represents the ERC404 token. This token is referred to as an "APtoken" and is divisible into 100 fractions, with each fraction representing 1% of the NFT. To own the APtoken completely, you would need to own all 100 tokens.


![intro-2.png](https://github.com/0xmetaschool/Learning-Projects/blob/main/assests_for_all/assests_for_erc404/1%20Getting%20Started/2%20What%20the%20Hell%20Is%20the%20ERC404/intro-2.webp?raw=true)

### ERC404 token standard contract implementation

ERC404 token contract have several functionalities, but four main functions help us create the token from end to end. Let’s discuss them using our APtoken example.

1. **Mint:** To own our "Artistic Ape" NFT, token ownership begins with the minting of tokens. The token creator issues new tokens for APtoken, up to a supply chain of 100 fractions. For instance, if you decide to buy all 100 fractions of the NFT, the creator will mint your tokens and you will have complete ownership of the NFT.
2. **Burn:** By using the burn function, you can reduce the total supply of your APtokens by burning some amount of tokens.
3. **Transfer:** If you choose to sell your tokens, you can transfer them to anyone using the transfer function. The function will first verify if you are the owner of the APtoken, and then it will change the ownership of your "Artistic Ape" NFT.
4. **BatchTransfer:** What if you have multiple buyers of your APtoken? Transferring the tokens to them individually will be a hassle. The **BatchTransfer** function enables you to transfer fractions of tokens to multiple addresses in a single transaction and modify the ownership of your "Artistic Ape" NFT.

## Let’s summarize

ERC404 is a very versatile token standard that manages NFTs (non-fungible tokens) very effectively. With this standard, you can link tokens with NFTs and divide the NFT into smaller fractions, with each fraction represented by a token. These tokens can be easily bought, sold, or traded with other kinds of tokens, which makes the NFTs more accessible and increases their liquidity. Furthermore, the minting mechanism ensures that the owners of the token fractions are kept up-to-date, making ERC404 a secure and reliable token standard.

You can find the Pandora ERC404 implementation [here](https://github.com/Pandora-Labs-Org/erc404).

## That’s a wrap

ERC404 token is again revolutionizing the crypto world. If you deeply develop its understanding, you can build your own ERC404 token and launch it on the chain just like the PANDORA token. But it surely does have some shortcomings. Let’s discuss them in the next lesson and introduce you to the DN404 token standard.