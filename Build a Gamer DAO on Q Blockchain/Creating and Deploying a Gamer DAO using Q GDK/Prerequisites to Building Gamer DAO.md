# Prerequisites to Building Gamer DAO

Welcome back folks! You did great so far. You even created a DAO using Solidity programming language. But did you notice some drawbacks that DAO had? In this lesson, I will explain to you how the Q DAO Factory can make your life easier in creating a DAO and how you can make your DAO more secure.

## Let’s look into the DAO we have created

In last section, we created a DAO. Was it good enough? Was it secure enough? It has multiple issues and it required a lot of work to set up. Let’s explore some of the problems.

1. The DAO doesn’t have any governance. We just created different functions that enables different functionalities for DAO but we didn’t decide any governance (decision making processes) for our DAO.
2. The DAO doesn’t have any native token. To make decisions and vote on something, each member should have a voting power and that voting power comes from tokens. But we didn’t create any token to give voting power to any member of the DAO.
3. It is not secure. Anyone in the DAO can propose anything and do whatever they wish to do within the DAO.
4. Above all, creating a simple DAO took a lot of work and coding. Think of how much long it will take to add more functionalities or rather have a front-end for your DAO.

Now, let’s explore how Q DAO Factory can help you solve everything we have discussed above.

## Q DAO Factory

Q DAO Factory is a tool available on the Q Blockchain that allows you to create a DAO simply using a front-end. It allows you to create a DAO without coding by only choosing from different options on the front-end. Following are some of the functionalities Q DAO Factory offers.

1. Q DAO Factory allows to create a native token for the DAO. Additionally, you could also use an existing token in your DAO. Which we will do later. So stay tuned!
2. If you create a token in the DAO Factory, it allows to add members to the DAO by simply minting the native DAO tokens to new members via a front-end.
3. It allows to add Custom Modules to the DAO, like the Merkle AirDrop module, which helps to distribute tokens to the members.

So before we get started and effortlessly deploy a DAO without any coding with the Q DAO Factory, let’s learn something about Merkel Trees first, to understand the Merkle AirDrop module.

## What exactly is a Merkle tree?

Merkle tree is a data structure that is used in various computer applications. In blockchain, it is used to encode data securely and efficiently. Merkle trees are also known as “binary hash trees.”

A Merkle tree is a tree data structure where so called “leaf nodes” represent the data and “non-leaf nodes” are the hashes of their children (which can be both leaf nodes, or non-leaf nodes). The hash is unique for each child node, which helps to ensure data security. If anyone changes anything in the data (the leaf nodes), all of the hashes change up to the root node, this helps to identify any tiny change in the data (leaf nodes), because you can clearly see a change in the root node.

Let’s look at how exactly a Merkle tree looks like.

![Frame 3560339 (4).png](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Prerequisites%20to%20Building%20Gamer%20DAO/Frame_3560339_(4).png?raw=true)

Here, “H(…)” represents the hash function of its child nodes and “A”, “B”, “C”, “D”, “E” and “F” represent the data present in the tree. The root node (”H(ABCDCDEF)”) contains the root hash of the complete tree.

Before moving forward, let’s first understand what is Merkle Proof.

## Merkle proof

Merkle proof is a way to check if any data belongs to Merkle tree or not without revealing the complete data from the Merkle tree.

For example, the user is giving the data “D.” Now, we need to verify whether the data belongs to the original tree or not.

To do this, we will use Merkle proof. Merkle proof will create a new tree, but this time instead of making a complete tree it will create the branch of tree that will involve the essential nodes to make a Merkle tree root node. 

Let’s look at the following tree. Here, Merkle proof is collecting some data from the original tree and generating some new data. The boxes in blue are picked from original Merkle tree whereas the boxes in red are the hashes Merkle proof generated itself.

![Frame 3560339 (11).png](https://github.com/0xmetaschool/Learning-Projects/blob/main/Build%20a%20Gamer%20DAO%20on%20Q%20Blockchain/Creating%20and%20Deploying%20a%20Gamer%20DAO%20using%20Q%20GDK/Prerequisites%20to%20Building%20Gamer%20DAO/Frame_3560339_(11).png?raw=true)

After generating the new Merkle root hash, it will be compared with the hash of the original Merkle tree root. If both of the hashes matches it means the data “D” given by the user is valid, otherwise it is not. Remember that even the slight change in data changes the hash of the branch and the root hash node.

## Role of a Merkle tree in the DAO

Merkle trees can be used for various purposes in DAOs. The main application is using a Merkle proof to verify the token distribution in the DAO. For example, a member wants to claim some tokens from the DAO. To verify if he is the member of the DAO or not, the Merkle proof generates new Merkle tree root hash and compares it with the original Merkle tree. If both of the hashes matches it means the member can claim the tokens, otherwise he/she cannot.

Merkle trees are often used in AirDrops. Now let’s understand how an AirDrop works and why it uses the Merkle tree concept.

## AirDrops and their role in DAOs

An AirDrop is basically a strategy that you can use to distribute multiple tokens at once to a list of wallet addresses. It is a strategy where you send tokens for free, or in return of a small service like asking to tweet about your newly created DAO. AirDrops are also often used as a marketing strategy where a project sends some tokens to a list of people to  promote their newly created token and DAO.

## Merkle AirDrop

Now, imagine your token is created and you just want to AirDrop your tokens to random wallet addresses in order to improve your DAO visibility. This causes two problems:

1.  You send tokens to users who dont play any vital role in your DAO.
2. Each time you send tokens it cost you high gas cost.

To solve these problems you can use a Merkle Tree to implement the AirDrop, which solves the problems following the following strategies.

1. You define a list of addresses, and only they shall be able to claim the tokens from the AirDrop.
2. Using this list of pre-defined addresses, you build a Merkle tree.
3. Only the Merkle root needs to be stored in the AirDrop contract to verify any member who wants to claim the tokens.
4. Now, people from your list can request to claim the token and they will be the one who will pay the transaction fee, not you.

## That’s a wrap

In upcoming lessons, you will implement everything we have covered in this lesson. You will create the DAO using Q DAO Factory then eventually start implementing the AirDrop module to make your DAO more secure and scalable.
