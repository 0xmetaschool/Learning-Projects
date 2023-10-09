# Prerequisites to Building a Gamer DAO

Welcome back folks! You did great so far. You created a DAO using Solidity programming language. But did you notice some drawbacks that DAO had? In this lesson, we will explain to you how the Q DAO Factory can make your life easier in creating a DAO and how you can make your DAO secure.

## Problems with our DAO:

In the previous section, we built a DAO. But was it good and secure enough? It turns out, there are several issues:

1. **Lack of Governance:** Our DAO lacks a set of rules for decision-making. We created functions for different actions, but we didn't establish any governance processes.
2. **No Native Token:** For members to vote and make decisions, they need voting power, which usually comes from tokens. However, we didn't create any tokens to grant voting power.
3. **Security Concerns:** Our DAO isn't secure. our DAO might have security bugs since the code is not audited
4. **Complex Setup:** Building this simple DAO required a lot of work and coding. Imagine how much more effort it would take to add more features or create a user-friendly front-end.

Now, let’s explore how Q DAO Factory can help you solve everything we have discussed above.

## Q DAO Factory

Q DAO Factory is a tool available on the Q Blockchain that allows you to create a DAO simply using the user interface. It allows you to create a DAO without coding. 

![q-dao-factory.webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/1.%20Prerequisites%20to%20Building%20Gamer%20DAO/q-dao-factory.webp)

1. **Easy DAO Creation:** Q DAO Factory simplifies creating a DAO without coding. It's like setting up a social club with a few clicks. Think of creating a social group on a social media platform—it's quick and straightforward.
2. **Native Token Creation:** Like a government distributing official voting cards to citizens for an election – Q DAO Factory allows you to create tokens for voting. It's similar to issuing voting cards for elections.
3. **Member Management:** You can easily add members to your DAO by issuing native tokens through the platform. Similar to admitting new members to a club by giving them membership cards.
4. **Custom Modules:** Just like adding a high-tech security system to protect your valuable items in a museum. Q DAO Factory lets you add specialized features like secure voting systems.

In summary, Q DAO Factory simplifies the creation and management of DAOs, addressing the issues and complexities faced when building them from scratch.

So before we get started and effortlessly deploy a DAO without any coding with the Q DAO Factory, let’s learn something about Merkle Trees first, to understand the Merkle AirDrop module.

## Merkle tree and Merkle proof

A **Merkle tree** is a data structure used in blockchain and other applications for secure data organization. Merkle trees are also known as “binary hash trees.”

It consists of "leaf nodes" representing data and "non-leaf nodes" containing unique hashes of their child nodes. If any data changes, it alters the hashes up to the root, making tampering evident. For example, in the example below, `A` and `B` are leaf nodes which has some data. `H(A)` and `H(B)` are the hashes of `A` and `B` respectively. Now, in Merkle tree, if you have a node `H(AB)`, you can identify that the hashes of A and B are present in node H(AB). Now consider our root node `H(ABCDCDEF)`, you can determine from this root hash that it contains a hash of `A`, `B`, `C`, `D`, `E` and `F`. While this might feel trivial, it has huge application in web3 and in computer science. Let us simplify it even more for you with a real case scenario.

![Frame 3560339 (4).webp](https://raw.githubusercontent.com/0xmetaschool/Learning-Projects/main/assests_for_all/assests_for_q/q-update/3.%20Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/1.%20Prerequisites%20to%20Building%20Gamer%20DAO/Frame_3560339_(4).webp)

You might have seen several projects announcing airdrops. For these airdrops, certain number of addresses are available. These addresses can be in thousands in number. Now imagine submitting all these addresses one by one on-chain. Sounds scary, right? The amount of gas it would take would be very huge. Here is where Merkle trees help us. You simply create a root hash of all the addresses that should be eligible and submit this hash on-chain. Now, in order to check if your address is eligible, you just need to check if the hash of your address is present in the root hash.  This also hugely reduces the gas cost. 

In short, a **Merkle proof** verifies data within a Merkle tree without revealing all the data. It builds a new tree with essential nodes and hashes, comparing the resulting root hash to check if the data is present within the Merkle tree.

Examples of where Merkle trees are used includes - In **DAOs**, Merkle trees are used for token distribution. During NFT minting, Merkle trees are used for whitelisted addresses who are eligible for minting. 

## That’s a wrap

In upcoming lessons, you will implement the concepts we discussed in this lesson. You will create the DAO using Q DAO Factory then eventually start implementing the AirDrop module to make your DAO more secure and scalable.